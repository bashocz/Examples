using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Numerics;
using System.Runtime.InteropServices;
using System.Windows.Media.Imaging;
using System.Drawing;
using System.Drawing.Imaging;

namespace Fourier.Domain
{
    public class ImageHelper
    {
        private static Complex[,] GetSignal(byte[] pixels, int width, int height, int stride, int bytesPerPixel)
        {
            Complex[,] signal = new Complex[width, height];
            for (int m = 0; m < width; m++)
                for (int n = 0; n < height; n++)
                {
                    int idx = n * stride + m * bytesPerPixel;
                    int sum = 0;
                    for (int i = 0; i < bytesPerPixel; i++)
                        sum += pixels[idx + i];
                    signal[m, n] = new Complex((double)sum / ((double)bytesPerPixel * 256.0d), 0);
                }
            return signal;
        }

        private static void GetPixels(Complex[,] signal, byte[] pixels, int width, int height, int stride)
        {
            for (int m = 0; m < width; m++)
                for (int n = 0; n < height; n++)
                {
                    int idx = n * stride + m * 3;
                    int color = (int)(256 * signal[m, n].Magnitude);
                    if (color > 255) color = 255;
                    if (color < 0) color = 0;
                    pixels[idx] = (byte)color;
                    pixels[idx + 1] = (byte)color;
                    pixels[idx + 2] = (byte)color;
                }
        }

        public static Complex[,] GetSignal(Bitmap bitmap)
        {
            if (bitmap.PixelFormat == PixelFormat.Format8bppIndexed)
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                Complex[,] signal = GetSignal(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 1);

                bitmap.UnlockBits(bitmapData);

                return signal;
            }
            else if (bitmap.PixelFormat == PixelFormat.Format24bppRgb)
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                Complex[,] signal = GetSignal(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 3);

                bitmap.UnlockBits(bitmapData);

                return signal;
            }
            else if ((bitmap.PixelFormat == PixelFormat.Format32bppRgb) || (bitmap.PixelFormat == PixelFormat.Format32bppArgb))
            {
                BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadOnly, bitmap.PixelFormat);
                int bytes = bitmapData.Stride * bitmap.Height;
                byte[] pixels = new byte[bytes];
                Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

                Complex[,] signal = GetSignal(pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride, 4);

                bitmap.UnlockBits(bitmapData);

                return signal;
            }
            return null;
        }

        public static Bitmap GetBitmap(Complex[,] signal)
        {
            Bitmap bitmap = new Bitmap(signal.GetLength(0), signal.GetLength(1), PixelFormat.Format24bppRgb);

            BitmapData bitmapData = bitmap.LockBits(new Rectangle(0, 0, bitmap.Width, bitmap.Height), ImageLockMode.ReadWrite, bitmap.PixelFormat);
            int bytes = Math.Abs(bitmapData.Stride) * bitmap.Height;
            byte[] pixels = new byte[bytes];
            Marshal.Copy(bitmapData.Scan0, pixels, 0, bytes);

            GetPixels(signal, pixels, bitmapData.Width, bitmapData.Height, bitmapData.Stride);

            Marshal.Copy(pixels, 0, bitmapData.Scan0, bytes);
            bitmap.UnlockBits(bitmapData);

            return bitmap;
        }
    }
}
