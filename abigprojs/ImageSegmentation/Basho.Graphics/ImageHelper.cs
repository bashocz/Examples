using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Drawing;
using System.Drawing.Imaging;

namespace ImageSegmentation.Helper
{
    public static class ImageHelper
    {
        private static byte[,] GetIntensities(byte[] pixels, int width, int height, int stride, int bytesPerPixel)
        {
            byte[,] intensities = new byte[width, height];
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                {
                    int idx = j * stride + i * bytesPerPixel;
                    int sum = 0;
                    for (int b = 0; b < bytesPerPixel; b++)
                        sum += pixels[idx + b];
                    intensities[i, j] = (byte)(sum / bytesPerPixel);
                }
            return intensities;
        }

        private static int[,] GetSegments(byte[] pixels, int width, int height, int stride, int bytesPerPixel)
        {
            int[,] segments = new int[width, height];
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                {
                    int idx = j * stride + i * bytesPerPixel;
                    int seg = 0;
                    for (int b = 0; b < bytesPerPixel; b++)
                        seg += (pixels[idx + b] << (b * 8));
                    segments[i, j] = seg;
                }
            return segments;
        }

        private static void FillPixels(int[,] segments, byte[] pixels, int width, int height, int stride)
        {
            Random random = new Random();
            Dictionary<int, byte[]> colors = new Dictionary<int, byte[]>();
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                {
                    int idx = j * stride + i * 3;
                    if (!colors.Keys.Contains(segments[i, j]))
                    {
                        byte[] rgb = new byte[3];
                        random.NextBytes(rgb);
                        colors.Add(segments[i, j], rgb);
                    }
                    byte[] color = colors[segments[i, j]];
                    pixels[idx] = color[0];
                    pixels[idx + 1] = color[1];
                    pixels[idx + 2] = color[2];
                }
        }

        private static void FillFilterPixels(byte[,] filter, byte[] pixels, int width, int height, int stride)
        {
            Random random = new Random();
            Dictionary<int, byte[]> colors = new Dictionary<int, byte[]>();
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                {
                    int idx = j * stride + i * 3;
                    pixels[idx] = filter[i, j];
                    pixels[idx + 1] = filter[i, j];
                    pixels[idx + 2] = filter[i, j];
                }
        }

        public static byte[,] GetPixels(Bitmap bitmap)
        {
            if (bitmap.PixelFormat == PixelFormat.Format8bppIndexed)
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                byte[,] intensities = GetIntensities(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 1);

                bitmap.UnlockBits(bitmapData);

                return intensities;
            }
            else if (bitmap.PixelFormat == PixelFormat.Format24bppRgb)
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                byte[,] intensities = GetIntensities(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 3);

                bitmap.UnlockBits(bitmapData);

                return intensities;
            }
            else if ((bitmap.PixelFormat == PixelFormat.Format32bppRgb) || (bitmap.PixelFormat == PixelFormat.Format32bppArgb))
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                byte[,] intensities = GetIntensities(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 4);

                bitmap.UnlockBits(bitmapData);

                return intensities;
            }
            return null;
        }

        public static int[,] GetSegments(Bitmap bitmap)
        {
            if (bitmap.PixelFormat == PixelFormat.Format8bppIndexed)
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                int[,] segments = GetSegments(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 1);

                bitmap.UnlockBits(bitmapData);

                return segments;
            }
            else if (bitmap.PixelFormat == PixelFormat.Format24bppRgb)
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                int[,] segments = GetSegments(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 3);

                bitmap.UnlockBits(bitmapData);

                return segments;
            }
            else if ((bitmap.PixelFormat == PixelFormat.Format32bppRgb) || (bitmap.PixelFormat == PixelFormat.Format32bppArgb))
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                int[,] segments = GetSegments(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 4);

                bitmap.UnlockBits(bitmapData);

                return segments;
            }
            return null;
        }

        public static Bitmap GetBitmap(int[,] segments)
        {
            Bitmap bitmap = new Bitmap(segments.GetLength(0), segments.GetLength(1), PixelFormat.Format24bppRgb);

            BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadWrite, bitmap.PixelFormat);
            int bytes = Math.Abs(bitmapData.Stride) * bitmap.Height;
            byte[] pixels = new byte[bytes];
            Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

            FillPixels(segments, pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride);

            Marshal.Copy(pixels, 0, bitmapData.Scan0, bytes);
            bitmap.UnlockBits(bitmapData);

            return bitmap;
        }

        public static Bitmap GetFilterBitmap(byte[,] filter)
        {
            Bitmap bitmap = new Bitmap(filter.GetLength(0), filter.GetLength(1), PixelFormat.Format24bppRgb);

            BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadWrite, bitmap.PixelFormat);
            int bytes = Math.Abs(bitmapData.Stride) * bitmap.Height;
            byte[] pixels = new byte[bytes];
            Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

            FillFilterPixels(filter, pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride);

            Marshal.Copy(pixels, 0, bitmapData.Scan0, bytes);
            bitmap.UnlockBits(bitmapData);

            return bitmap;
        }
    }
}
