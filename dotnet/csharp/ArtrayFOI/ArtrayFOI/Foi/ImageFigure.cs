using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;

namespace Mapper.Equipment.Foi
{
    public class ImageFigure
    {
        private readonly int inkSizeInPixelMin = 40;

        private readonly Rectangle region;
        private readonly bool[,] figure;

        public ImageFigure(bool[,] figure, Rectangle region)
        {
            this.figure = figure;
            this.region = region;
        }

        #region fragmentation to figures

        private static void EnqueuePoint(Queue<Point> points, int x, int y, bool[,] pixels)
        {
            points.Enqueue(new Point(x, y));
            pixels[x, y] = false;
        }

        private static bool TestPoint(Queue<Point> points, bool[,] mark, bool[,] pixels, int x, int y, int width, int height)
        {
            if ((x >= 0) && (x < width) && (y >= 0) && (y < height))
                if (pixels[x, y] && !mark[x, y])
                    EnqueuePoint(points, x, y, pixels);
            return false;
        }

        private static bool[,] MarkTightPixels(bool[,] pixels, int x, int y, out Rectangle region)
        {
            int width = pixels.GetLength(0);
            int height = pixels.GetLength(1);
            int left = width;
            int right = -1;
            int top = height;
            int bottom = -1;

            bool[,] mark = new bool[width, height];

            Queue<Point> points = new Queue<Point>(width * height / 10);
            EnqueuePoint(points, x, y, pixels);

            while (points.Count > 0)
            {
                Point point = points.Dequeue();
                int i = point.X;
                int j = point.Y;

                mark[i, j] = true;

                if (i < left) left = i;
                if (i > right) right = i;
                if (j < top) top = j;
                if (j > bottom) bottom = j;

                TestPoint(points, mark, pixels, i + 1, j, width, height);
                TestPoint(points, mark, pixels, i, j + 1, width, height);
                TestPoint(points, mark, pixels, i - 1, j, width, height);
                TestPoint(points, mark, pixels, i, j - 1, width, height);
            }

            region = new Rectangle(left, top, right - left + 1, bottom - top + 1);

            return mark;
        }

        private static bool[,] CropFigure(bool[,] mark, Rectangle region)
        {
            bool[,] figure = new bool[region.Width, region.Height];
            for (int x = 0; x < region.Width; x++)
                for (int y = 0; y < region.Height; y++)
                    figure[x, y] = mark[x + region.Left, y + region.Top];
            return figure;
        }

        private static ImageFigure CreateFigure(bool[,] pixels, int x, int y)
        {
            Rectangle region;
            bool[,] mark = MarkTightPixels(pixels, x, y, out region);
            bool[,] figure = CropFigure(mark, region);
            return new ImageFigure(figure, region);
        }

        private static bool IsExistingFigure(List<ImageFigure> figures, int x, int y)
        {
            foreach (ImageFigure item in figures)
                if (item.IsFigurePixel(x, y))
                    return true;
            return false;
        }

        public static List<ImageFigure> FragmentToFigures(bool[,] pixels)
        {
            List<ImageFigure> figures = new List<ImageFigure>();

            int width = pixels.GetLength(0);
            int height = pixels.GetLength(1);

            for (int x = 0; x < width; x++)
                for (int y = 0; y < height; y++)
                    if (pixels[x, y] && !IsExistingFigure(figures, x, y))
                        figures.Add(CreateFigure(pixels, x, y));

            return figures;
        }

        #endregion fragmentation to figures

        public bool IsFigurePixel(int x, int y)
        {
            if (figure != null)
            {
                if ((x >= region.Left) && (x < region.Right) && (y >= region.Top) && (y < region.Bottom))
                    return figure[x - region.Left, y - region.Top];
            }
            return false;
        }

        public bool IsInk()
        {
            return (region.Width >= inkSizeInPixelMin) && (region.Height >= inkSizeInPixelMin);
        }
    }
}
