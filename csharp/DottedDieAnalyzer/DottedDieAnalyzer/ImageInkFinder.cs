using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using System.Drawing.Imaging;

namespace Basho.DottedDieAnalyzer
{
    class ImageInkFinder
    {
        private readonly byte[] pixels;
        private readonly PixelFormat pixelFormat;
        private readonly int pixelBytes;
        private readonly int width;
        private readonly int height;

        private readonly double inkBrightnessThreshold = 0.15;

        public ImageInkFinder(byte[] pixels, PixelFormat pixelFormat, int pixelBytes, int width, int height)
        {
            if ((pixelFormat != PixelFormat.Format24bppRgb) &&
                (pixelFormat != PixelFormat.Format32bppArgb))
                throw new ArgumentException("Unsupported pixel format.", "pixelFormat");

            this.pixels = pixels;
            this.pixelFormat = pixelFormat;
            this.pixelBytes = pixelBytes;
            this.width = width;
            this.height = height;
        }

        private double GetBrightness(int x, int y)
        {
            int pixelIdx = y * width * pixelBytes + x * pixelBytes;
            return ((double)(pixels[pixelIdx + 0] + pixels[pixelIdx + 1] + pixels[pixelIdx + 2])) / 3.0 / 255.0;

            //double brightness;
            //switch (pixelFormat)
            //{
            //    case PixelFormat.Format24bppRgb:
            //    case PixelFormat.Format32bppArgb:
            //        brightness = pixels[pixelIdx + 0] + pixels[pixelIdx + 1] + pixels[pixelIdx + 2];
            //        brightness /= 3;
            //        break;
            //    default:
            //}

            //return brightness / 255.0;
        }

        private bool[,] PrepareBwPixels()
        {
            bool[,] bwPixels = new bool[width, height];
            for (int x = 0; x < width; x++)
                for (int y = 0; y < height; y++)
                    bwPixels[x, y] = GetBrightness(x, y) < inkBrightnessThreshold;
            return bwPixels;
        }

        private bool FindInk(bool[,] bwPixels)
        {
            bool isInk = false;

            List<ImageFigure> figures = ImageFigure.FragmentToFigures(bwPixels);
            foreach (ImageFigure figure in figures)
                isInk |= figure.IsInk();

            return isInk;
        }

        public bool IsInk()
        {
            return FindInk(PrepareBwPixels());
        }
    }
}
