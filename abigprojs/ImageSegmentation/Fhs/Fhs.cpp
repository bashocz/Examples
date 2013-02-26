// This is the main DLL file.

#include "stdafx.h"

#include "Fhs.h"


namespace Fhs {

    double Fhs::min(double a, double b)
    {
        return (b < a) ? b : a;
    }

    void Fhs::init(unsigned char *src, int width, int height, int stride, int bytesPerPixel, unsigned char *dst, double sigma, int k)
    {
        this->src = src;
        this->width = width;
        this->height = height;
        this->stride = stride;
        this->bytesPerPixel = bytesPerPixel;
        this->dst = dst;
        this->sigma = sigma;
        this->k = k;

        bw = NULL;

        gR = 0;
        gMatrixSize = 0;
        gMatrix = NULL;

        nodes = NULL;
        components = NULL;
        edges = NULL;
        edgePockets = NULL;
    }

    void Fhs::cleanUp()
    {
        if (bw != NULL)
            delete bw;
        bw = NULL;

        if (gMatrix != NULL)
            delete gMatrix;
        gMatrix = NULL;

        if (nodes != NULL)
            delete nodes;
        nodes = NULL;

        if (components != NULL)
            delete components;
        components = NULL;

        if (edges != NULL)
            delete edges;
        edges = NULL;

        if (edgePockets != NULL)
            delete edgePockets;
        edgePockets = NULL;
    }

    void Fhs::createBw()
    {
        bw = new unsigned char[width * height];
    }

    void Fhs::createGaussianKernel()
    {
        gR = (int)ceil(2 * sigma);
        gMatrixSize = 2 * gR + 1;
        gMatrix = new double[gMatrixSize * gMatrixSize];

        if (gMatrixSize == 1)
        {
            gMatrix[0, 0] = 1;
            return;
        }

        double sigma22 = 2 * sigma * sigma;
        double sigma2Pi2 = 2 * M_PI * sigma * sigma;

        double total = 0, value;
        for (int i = -gR; i <= gR; i++)
            for (int j = -gR; j <= gR; j++)
            {
                value = (double)exp(-(i * i + j * j) / sigma22) / sigma2Pi2;
                gMatrix[(i + gR) * gMatrixSize + j + gR] = value;
                total += value;
            }

        for (int i = -gR; i <= gR; i++)
            for (int j = -gR; j <= gR; j++)
                gMatrix[(i + gR) * gMatrixSize + j + gR] /= total;
    }

    void Fhs::createGraph()
    {
        nodes = new NODE[width * height];
        components = new COMPONENT[width * height];
        edges = new EDGE[4 * width * height];
        edgePockets = new EDGE*[256];
        for (int i = 0; i < 256; i++)
            edgePockets[i] = NULL;
    }

    int Fhs::getGaussianPixelIndes(int i, int max)
    {
        if (i < 0)
            return abs(i);
        else if (i >= max)
            return max - abs(i - max + 1);
        return i;
    }

    void Fhs::applyGaussianBlur()
    {
        unsigned char *gb = new unsigned char[width * height];
        
        int i, j, l, k, pixel;
        double sum, gValue;
        for (j = 0; j < height; j++)
            for (i = 0; i < width; i++)
            {
                sum = 0;
                for (l = 0; l < gMatrixSize; l++)
                    for (k = 0; k < gMatrixSize; k++)
                    {
                        gValue = gMatrix[l * gMatrixSize + k];
                        pixel = bw[getGaussianPixelIndes(j + l - gR, height) * width + getGaussianPixelIndes(i + k - gR, width)];
                        sum += gValue * (double)pixel;
                    }

                gb[j * width + i] = (unsigned char)floor(sum + 0.5);
            }

        delete bw; // delete original bw array (not needed -> gaussian blur apllied)
        bw = gb;
    }

    void Fhs::initGraph()
    {
        int i, j , n1, n2;
        for (j = 0; j < height; j++)
            for (i = 0; i < width; i++)
            {
                n1 = j * width + i;
                // initialize node
                nodes[n1].comp = &components[n1];
                nodes[n1].next = NULL;
                // initialize component
                components[n1].index = -1;
                components[n1].count = 1;
                components[n1].intPtau = k;
                components[n1].first = components[n1].last = &nodes[n1];
                // initialize edge
                if (((i + 1) < width) && ((j - 1) >= 0)) // up-right pixel
                {
                    n2 = (j - 1) * width + i + 1;
                    initEdge(4 * n1, &nodes[n1], &nodes[n2], (int)abs((int)bw[n1] - (int)bw[n2]));
                }
                if ((i + 1) < width) // right pixel
                {
                    n2 = n1 + 1;
                    initEdge(4 * n1 + 1, &nodes[n1], &nodes[n2], (int)abs((int)bw[n1] - (int)bw[n2]));
                }
                if (((i + 1) < width) && ((j + 1) < height)) // down-right pixel
                {
                    n2 = (j + 1) * width + i + 1;
                    initEdge(4 * n1 + 2, &nodes[n1], &nodes[n2], (int)abs((int)bw[n1] - (int)bw[n2]));
                }
                if ((j + 1) < height) // down pixel
                {
                    n2 = (j + 1) * width + i;
                    initEdge(4 * n1 + 3, &nodes[n1], &nodes[n2], (int)abs((int)bw[n1] - (int)bw[n2]));
                }
            }
    }

    void Fhs::initEdge(int idx, NODE *v1, NODE *v2, int diff)
    {
        if ((diff >= 0) && (diff < 256))
        {
            edges[idx].v1 = v1;
            edges[idx].v2 = v2;
            edges[idx].next = edgePockets[diff];
            edgePockets[diff] = &edges[idx];
        }
    }

    void Fhs::processGraph()
    {
        int i, append;
        EDGE *actual;
        COMPONENT *c1, *c2;
        for (i = 0; i < 256; i++)
        {
            append = 0;
            actual = edgePockets[i];
            while (actual != NULL)
            {
                if ((actual->v1->comp != actual->v2->comp) &&
                    (i < min(actual->v1->comp->intPtau, actual->v2->comp->intPtau)))
                {
                    if (actual->v2->comp->count < actual->v1->comp->count)
                    {
                        c1 = actual->v1->comp;
                        c2 = actual->v2->comp;
                    }
                    else
                    {
                        c1 = actual->v2->comp;
                        c2 = actual->v1->comp;
                    }
                    appendComp(c1, c2, i);
                    append++;
                }
                actual = actual->next;
            }
        }
    }

    void Fhs::appendComp(COMPONENT *c1, COMPONENT *c2, double weight)
    {
        NODE *nodeB = c2->first;
        while (nodeB != NULL)
        {
            nodeB->comp = c1;
            nodeB = nodeB->next;
        }
        c1->last->next = c2->first;
        c1->last = c2->last;
        c1->count += c2->count;
        c1->intPtau = weight + k / c1->count;
    }

    void Fhs::srcToBw()
    {
        int i, j, b, iPxl, sum;
        unsigned char byte;
        for (j = 0; j < height; j++)
            for (i = 0; i < width; i++)
            {
                iPxl = j * stride + i * bytesPerPixel;
                sum = 0;
                for (b = 0; b < bytesPerPixel; b++)
                    sum += src[iPxl + b];
                byte = sum / bytesPerPixel;
                bw[j * width + i] = byte;
            }
    }

    void Fhs::bwToDst()
    {
        int i, j, b, iPxl;
        for (j = 0; j < height; j++)
            for (i = 0; i < width; i++)
            {
                iPxl = j * stride + i * bytesPerPixel;
                for (b = 0; b < bytesPerPixel; b++)
                    dst[iPxl + b] = bw[j * width + i];
            }
    }

    void Fhs::segmentToDst()
    {
        int i, j, b, iPxl, iNode, iComp = 0;
        unsigned char *index;
        for (j = 0; j < height; j++)
            for (i = 0; i < width; i++)
            {
                iPxl = j * stride + i * bytesPerPixel;
                iNode = j * width + i;
                if (nodes[iNode].comp->index < 0)
                {
                    nodes[iNode].comp->index = iComp;
                    iComp++;
                }
                index = (unsigned char *) &(nodes[iNode].comp->index);
                for (b = 0; b < bytesPerPixel; b++)
                    dst[iPxl + b] = index[b];
            }
    }

    void Fhs::gaussian(unsigned char *src, int width, int height, int stride, int bytesPerPixel, unsigned char *dst, double sigma)
    {
        init(src, width, height, stride, bytesPerPixel, dst, sigma, 0);

        createBw();
        srcToBw();

        if (sigma > 0)
        {
            createGaussianKernel();
            applyGaussianBlur();
        }

        bwToDst();

        cleanUp();
    }

    void Fhs::fhs(unsigned char *src, int width, int height, int stride, int bytesPerPixel, unsigned char *dst, double sigma, int k)
    {
        init(src, width, height, stride, bytesPerPixel, dst, sigma, k);

        createBw();
        srcToBw();

        if (sigma > 0)
        {
            createGaussianKernel();
            applyGaussianBlur();
        }

        createGraph();
        initGraph();
        processGraph();

        segmentToDst();

        cleanUp();
    }

}
