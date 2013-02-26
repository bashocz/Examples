using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Basho.Graphics.Filter;

namespace Basho.Graphics.Segmentation
{
    public class FhSegmentation : IFhSegmentation
    {
        #region private fields

        private FhNode[,] nodes;
        private FhComponent[] components;
        private FhEdge[] edges;
        private FhEdge[] edgePockets;

        #endregion

        #region private methods

        private void CreateArrays(int width, int height)
        {
            nodes = new FhNode[width, height];
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                    nodes[i,j] = new FhNode();
            components = new FhComponent[width * height];
            for (int i = 0; i < components.Length; i++)
                components[i] = new FhComponent();
            edges = new FhEdge[4 * width * height];
            for (int i = 0; i < edges.Length; i++)
                edges[i] = new FhEdge();
            edgePockets = new FhEdge[256];
        }

        private void FillArrays(int width, int height, byte[,] pixels, int k)
        {
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                {
                    int c = j * width + i;
                    // initialize node
                    nodes[i, j].Component = components[c];
                    // initialize component
                    components[c].Index = -1;
                    components[c].Count = 1;
                    components[c].IntPtau = k;
                    components[c].First = components[c].Last = nodes[i, j];
                    // initialize edge
                    if (((i + 1) < width) && ((j - 1) >= 0))
                        CreateEdge(4 * c, nodes[i, j], nodes[i + 1, j - 1], Math.Abs((int)pixels[i, j] - (int)pixels[i + 1, j - 1]));
                    if ((i + 1) < width)
                        CreateEdge(4 * c + 1, nodes[i, j], nodes[i + 1, j], Math.Abs((int)pixels[i, j] - (int)pixels[i + 1, j]));
                    if (((i + 1) < width) && ((j + 1) < height))
                        CreateEdge(4 * c + 2, nodes[i, j], nodes[i + 1, j + 1], Math.Abs((int)pixels[i, j] - (int)pixels[i + 1, j + 1]));
                    if ((j + 1) < height)
                        CreateEdge(4 * c + 3, nodes[i, j], nodes[i, j + 1], Math.Abs((int)pixels[i, j] - (int)pixels[i, j + 1]));
                }
        }

        private void CreateEdge(int idx, FhNode v1, FhNode v2, int diff)
        {
            if ((diff >= 0) && (diff < 256))
            {
                edges[idx].V1 = v1;
                edges[idx].V2 = v2;
                edges[idx].Next = edgePockets[diff];
                edgePockets[diff] = edges[idx];
            }
        }

        private void DoAlgorithm(int k)
        {
            for (int idx = 0; idx < 256; idx++)
            {
                int append = 0;
                FhEdge actual = edgePockets[idx];
                while (actual != null)
                {
                    if ((actual.V1.Component != actual.V2.Component) &&
                        ((double)idx < Math.Min(actual.V1.Component.IntPtau, actual.V2.Component.IntPtau)))
                    {
                        FhComponent c1, c2;
                        if (actual.V1.Component.Count >= actual.V2.Component.Count)
                        {
                            c1 = actual.V1.Component;
                            c2 = actual.V2.Component;
                        }
                        else
                        {
                            c1 = actual.V2.Component;
                            c2 = actual.V1.Component;
                        }
                        AppendComponent(c1, c2, idx, k);
                        append++;
                    }
                    actual = actual.Next;
                }
            }
        }

        private void AppendComponent(FhComponent c1, FhComponent c2, double weight, double k)
        {
            FhNode nodeB = c2.First;
            while (nodeB != null)
            {
                nodeB.Component = c1;
                nodeB = nodeB.Next;
            }
            c1.Last.Next = c2.First;
            c1.Last = c2.Last;
            c1.Count += c2.Count;
            c1.IntPtau = weight + k / (double)c1.Count;
        }

        private int[,] ReindexSegments(int width, int height)
        {
            int[,] segments = new int[width, height];
            int idx = 0;
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                {
                    if (nodes[i, j].Component.Index < 0)
                    {
                        nodes[i, j].Component.Index = idx;
                        idx++;
                    }
                    segments[i, j] = nodes[i, j].Component.Index;
                }
            return segments;
        }

        #endregion

        #region IFhSegmentation members

        public int[,] BuildSegments(int width, int height, byte[,] pixels, int k)
        {
            try
            {
                CreateArrays(width, height);
                FillArrays(width, height, pixels, k);
                DoAlgorithm(k);
                return ReindexSegments(width, height);
            }
            catch (Exception)
            {
                throw;
            }
        }

        #endregion
    }
}
