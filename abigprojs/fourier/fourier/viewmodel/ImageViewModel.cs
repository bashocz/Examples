using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Media;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Media.Imaging;
using System.Windows;
using System.ComponentModel;

namespace Fourier.ViewModel
{
    class ImageViewModel : NotifiableObject
    {
        public ImageViewModel(string caption, Bitmap bitmap)
        {
            Caption = caption;
            Bitmap = bitmap;
        }

        public string Caption { get; private set; }
        public Bitmap Bitmap { get; private set; }

        [DllImport("gdi32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        internal static extern bool DeleteObject(IntPtr hObject);

        public static BitmapSource ToBitmapSource(Bitmap source)
        {
            BitmapSource bitSrc = null;
            var hBitmap = source.GetHbitmap();
            try
            {
                bitSrc = System.Windows.Interop.Imaging.CreateBitmapSourceFromHBitmap(hBitmap, IntPtr.Zero, Int32Rect.Empty, BitmapSizeOptions.FromEmptyOptions());
            }
            catch (Win32Exception)
            {
                bitSrc = null;
            }
            finally
            {
                DeleteObject(hBitmap);
            }
            return bitSrc;
        }

        private BitmapSource _image;
        public BitmapSource Image
        {
            get { return _image ?? (_image = ToBitmapSource(Bitmap)); }
        }
    }
}
