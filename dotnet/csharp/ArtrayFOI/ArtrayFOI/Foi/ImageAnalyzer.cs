using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using System.Drawing.Imaging;

namespace Mapper.Equipment.Foi
{
    public class ImageAnalyzer
    {
        private readonly byte[] pixels;
        private readonly PixelFormat pixelFormat;
        private readonly int width;
        private readonly int height;

        private readonly double inkBrightnessThreshold = 0.15;

        public ImageAnalyzer(byte[] pixels, PixelFormat pixelFormat, int width, int height)
        {
            if ((pixelFormat != PixelFormat.Format8bppIndexed) &&
                (pixelFormat != PixelFormat.Format24bppRgb) &&
                (pixelFormat != PixelFormat.Format32bppArgb))
                throw new ArgumentException("Unsupported pixel format.", "pixelFormat");

            this.pixels = pixels;
            this.pixelFormat = pixelFormat;
            this.width = width;
            this.height = height;
        }

        private double GetBrightness(int x, int y)
        {
            int pixelIdx;
            double brightness = 0;
            switch (pixelFormat)
            {
                case PixelFormat.Format8bppIndexed:
                    brightness = pixels[y * width + x];
                    break;
                case PixelFormat.Format24bppRgb:
                    pixelIdx = y * width * 3 + x * 3;
                    brightness = pixels[pixelIdx + 0] + pixels[pixelIdx + 1] + pixels[pixelIdx + 2];
                    brightness /= 3;
                    break;
                case PixelFormat.Format32bppArgb:
                    pixelIdx = y * width * 4 + x * 4;
                    brightness = pixels[pixelIdx + 0] + pixels[pixelIdx + 1] + pixels[pixelIdx + 2];
                    brightness /= 3;
                    break;
            }

            return brightness / 255.0; // < 0, 1 >
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

        public bool IsInk(TimeMeter meter)
        {
            meter.Start("Image converting");
            bool[,] bwPixels = PrepareBwPixels();

            meter.Start("Image analysis");
            return FindInk(bwPixels);
        }

        public ArtCamBitmap GetBwBitmap()
        {
            bool[,] bwPixels = PrepareBwPixels();

            ArtCamBitmap bwBmp = new ArtCamBitmap(new Rectangle(0, 0, width, height), PixelFormat.Format1bppIndexed, null);

            for (int x = 0; x < width; x++)
                for (int y = 0; y < height; y++)
                {
                    int bmpIdx = (x / 8) + bwBmp.Stride * y;
                    byte pixel = 0;
                    if (bwPixels[x, y])
                        pixel = (byte)Math.Pow(2, 7 - (x % 8));
                    bwBmp.Pixels[bmpIdx] |= pixel;
                }

            return bwBmp;
        }
    }
}
