using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using System.Drawing.Imaging;

namespace Mapper.Equipment.Foi
{
    public class ImageConvertor
    {
        private readonly ArtCamBitmap bitmap;

        public ImageConvertor(ArtCamBitmap bitmap)
        {
            this.bitmap = bitmap;
        }

        public ArtCamBitmap GetImageAnalyzer(TimeMeter meter, bool shrink)
        {
            meter.Start("Image resizing");

            int ratioX = (bitmap.Rect.Width > 400) ? (bitmap.Rect.Width + 200) / 400 : 1;
            int ratioY = (bitmap.Rect.Height > 400) ? (bitmap.Rect.Height + 200) / 400 : 1;
            int width = bitmap.Rect.Width / ratioX;
            int height = bitmap.Rect.Height / ratioY;

            ArtCamBitmap convertBmp;

            if (((ratioX > 1) || (ratioY > 1)) && shrink)
            {
                convertBmp = new ArtCamBitmap(new Rectangle(0, 0, width, height), bitmap.Bitmap.PixelFormat, null);

                int bytesPerPixel = 1;
                switch (bitmap.Bitmap.PixelFormat)
                {
                    case PixelFormat.Format24bppRgb:
                        bytesPerPixel = 3;
                        break;
                    case PixelFormat.Format32bppArgb:
                        bytesPerPixel = 4;
                        break;
                }

                int[] sum = new int[bytesPerPixel];

                for (int i = 0; i < width; i++)
                    for (int j = 0; j < height; j++)
                    {
                        for (int b = 0; b < bytesPerPixel; b++)
                            sum[b] = 0;

                        int idx = 0;
                        int cnt = 0;
                        for (int x = i * ratioX; x < Math.Min(bitmap.Rect.Width, (i + 1) * ratioX); x++)
                            for (int y = j * ratioY; y < Math.Min(bitmap.Rect.Height, (j + 1) * ratioY); y++)
                            {
                                idx = y * bitmap.Rect.Width * bytesPerPixel + x * bytesPerPixel;
                                for (int b = 0; b < bytesPerPixel; b++)
                                    sum[b] += bitmap.Pixels[idx + b];
                                cnt++;
                            }
                        idx = j * width * bytesPerPixel + i * bytesPerPixel;
                        for (int b = 0; b < bytesPerPixel; b++)
                            convertBmp.Pixels[idx + b] = (byte)(sum[b] / cnt);
                    }
            }
            else
                convertBmp = bitmap;

            return convertBmp;
        }
    }
}
