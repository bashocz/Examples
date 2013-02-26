using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using System.Drawing.Imaging;

namespace Basho.DottedDieAnalyzer
{
    class ImageConverter
    {
        public ImageInkFinder GetImageInkFinder(Bitmap bitmap)
        {
            // Lock the bitmap's bits.  
            Rectangle rect = new Rectangle(0, 0, bitmap.Width, bitmap.Height);
            BitmapData bmpData = bitmap.LockBits(rect, ImageLockMode.ReadWrite, bitmap.PixelFormat);

            // Get the address of the first line.
            IntPtr ptr = bmpData.Scan0;

            // Declare an array to hold the bytes of the bitmap.
            int bytes = bmpData.Stride * bitmap.Height;
            byte[] rgbValues = new byte[bytes];

            int pixelBytes = bmpData.Stride / bmpData.Width;

            // Copy the RGB values into the array.
            System.Runtime.InteropServices.Marshal.Copy(ptr, rgbValues, 0, bytes);

            // Unlock the bits.
            bitmap.UnlockBits(bmpData);

            return new ImageInkFinder(rgbValues, bitmap.PixelFormat, pixelBytes, bitmap.Width, bitmap.Height);
        }

        public ImageInkFinder GetImageInkFinder(string fileName)
        {
            return GetImageInkFinder(new Bitmap(fileName));
        }
    }
}
