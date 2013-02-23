using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Drawing.Imaging;

namespace Mapper.Equipment.Foi
{
    public class ArtCamBitmap
    {
        private readonly Rectangle rect;
        private readonly PixelFormat pixelFormat;

        private readonly Bitmap bitmap;
        private readonly byte[] pixels;
        private int stride;

        private readonly ArtCamHelper helper;

        public ArtCamBitmap(Rectangle rect, PixelFormat pixelFormat, ArtCamHelper helper)
        {
            this.rect = rect;
            this.pixelFormat = pixelFormat;

            this.helper = helper;

            bitmap = CreateBitmap();
            pixels = CreatePixels();
        }

        public event EventHandler BitmapUpdated;

        public void UpdateBitmap(TimeMeter meter)
        {
            if ((bitmap == null) || (pixels == null))
                return;
            if (meter != null)
            meter.Start("Bitmap update");

            BitmapData bmpData = bitmap.LockBits(new Rectangle(0, 0, rect.Width, rect.Height), ImageLockMode.ReadWrite, pixelFormat);

            if (stride != bmpData.Stride)
            {
                bitmap.UnlockBits(bmpData);
                throw new ApplicationException("Unsupported format, different stride value...");
            }

            IntPtr pdest = bmpData.Scan0;
            int bytes = bmpData.Stride * bitmap.Height;
            byte[] values = new byte[bytes];

            System.Runtime.InteropServices.Marshal.Copy(pdest, values, 0, bytes);

            int size = Math.Min(bytes, pixels.Length);
            for (int i = 0; i < size; i++)
                values[i] = pixels[i];

            System.Runtime.InteropServices.Marshal.Copy(values, 0, pdest, bytes);

            bitmap.UnlockBits(bmpData);

            if (BitmapUpdated != null)
            {
                EventHandler bmp = BitmapUpdated;
                bmp(this, EventArgs.Empty);
            }
        }

        private Bitmap CreateBitmap()
        {
            Bitmap bmp = new Bitmap(rect.Width, rect.Height, pixelFormat);

            if (pixelFormat == PixelFormat.Format1bppIndexed)
            {
                ColorPalette palette = bmp.Palette;
                Color[] entries = bmp.Palette.Entries;

                entries.SetValue(Color.FromArgb(255, 255, 255), 0);
                palette.Entries[0] = entries[0];
                entries.SetValue(Color.FromArgb(0, 0, 0), 1);
                palette.Entries[1] = entries[1];

                bmp.Palette = palette;
            }
            else if (pixelFormat == PixelFormat.Format8bppIndexed)
            {
                ColorPalette palette = bmp.Palette;
                Color[] entries = bmp.Palette.Entries;

                for (int i = 0; i < 256; i++)
                {
                    entries.SetValue(Color.FromArgb(i, i, i), i);
                    palette.Entries[i] = entries[i];
                }
                bmp.Palette = palette;
            }
            return bmp;
        }

        private byte[] CreatePixels()
        {
            byte[] pxls = null;
            stride = 0;
            switch (pixelFormat)
            {
                case PixelFormat.Format1bppIndexed:
                    stride = (rect.Width + 7) / 8;
                    stride = ((stride + 3) / 4) * 4;
                    break;
                case PixelFormat.Format8bppIndexed:
                    stride = rect.Width;
                    break;
                case PixelFormat.Format24bppRgb:
                    stride = rect.Width * 3;
                    break;
                case PixelFormat.Format32bppArgb:
                    stride = rect.Width * 4;
                    break;
            }
            return new byte[stride * rect.Height]; ;
        }

        public Bitmap Bitmap
        {
            get { return bitmap; }
        }

        public byte[] Pixels
        {
            get { return pixels; }
        }

        public Rectangle Rect
        {
            get { return rect; }
        }

        public int Stride
        {
            get { return stride; }
        }

        public void Snapshot(TimeMeter meter)
        {
            if (helper == null)
                throw new NullReferenceException("helper can't be null.");

            if ((helper.Width != rect.Width) || (helper.Height != rect.Height))
            {
                meter.Start("Library init");

                helper.Close();

                helper.SetPreviewWindow(System.IntPtr.Zero, 0, 0, 0, 0);

                helper.SetCaptureWindow(3488, rect.Left, rect.Width, 2616, rect.Top, rect.Height);
            }

            meter.Start("Snapshot");
            helper.Snapshot(pixels);
        }
    }
}
