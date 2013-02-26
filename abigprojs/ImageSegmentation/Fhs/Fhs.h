// Fhs.h

#pragma once

#define _USE_MATH_DEFINES

#include <cstdlib>
#include <math.h>

using namespace System;

namespace Fhs {

	struct NODE;

	struct COMPONENT {
		int index, count;
		double intPtau;
		NODE *first, *last;
	};

	struct NODE {
		COMPONENT *comp;
		NODE *next;
	};

	struct EDGE {
		NODE *v1, *v2;
		EDGE *next;
	};

	public ref class Fhs
	{
	public:
		void gaussian(unsigned char *src, int width, int height, int stride, int bytesPerPixel, unsigned char *dst, double sigma);
		void fhs(unsigned char *src, int width, int height, int stride, int bytesPerPixel, unsigned char *dst, double sigma, int k);

	private:
		// input parameters
		unsigned char *src, *dst;
		int width, height, stride, bytesPerPixel;
		double sigma;
		double k;

		// black & white two-dimensional image array (256 steps)
		unsigned char *bw;

		// gaussian blur
		int gR;
		int gMatrixSize;
		double *gMatrix;

		// graph
		NODE *nodes;
		COMPONENT *components;
		EDGE *edges;
		EDGE **edgePockets;

		// temporary
		double min(double a, double b);

		// initialization functions
		void init(unsigned char *src, int width, int height, int stride, int bytesPerPixel, unsigned char *dst, double sigma, int k);
		void cleanUp();
		
		void createBw();
		void createGaussianKernel();
		void createGraph();

		// gaussian functions
		int getGaussianPixelIndes(int i, int max);
		void applyGaussianBlur();

		// graph functions
		void initGraph();
		void initEdge(int idx, NODE *v1, NODE *v2, int diff);
		void processGraph();
		void appendComp(COMPONENT *c1, COMPONENT *c2, double weight);

		// copy functions
		void srcToBw();
		void bwToDst();
		void segmentToDst();
	};
}
