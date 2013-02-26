#region Header
//
//   Project:           WriteableBitmapEx - Silverlight WriteableBitmap extensions
//   Description:       Collection of interchange extension methods for the Silverlight WriteableBitmap class.
//
//   Changed by:        $Author$
//   Changed on:        $Date$
//   Changed in:        $Revision$
//   Project:           $URL$
//   Id:                $Id$
//
//
//   Copyright © 2009 Rene Schulte and WriteableBitmapEx Contributors
//
//   This Software is weak copyleft open source. Please read the License.txt for details.
//
#endregion

namespace System.Windows.Media.Imaging
{
   /// <summary>
   /// Collection of interchange extension methods for the Silverlight WriteableBitmap class.
   /// </summary>
   public static partial class WriteableBitmapExtensions
   {
      #region Fields

      private const int BufferStrideByteARGB = 4;

      #endregion

      #region Methods

      #region Byte Array

      /// <summary>
      /// Copies the Pixels from the WriteableBitmap into a ARGB byte array starting at a specific Pixels index.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="offset">The starting Pixels index.</param>
      /// <param name="count">The number of Pixels to copy.</param>
      /// <returns>The color buffer as byte ARGB values.</returns>
      public static byte[] ToByteArray(this WriteableBitmap bmp, int offset, int count)
      {
         // Init buffer
         int w = bmp.PixelWidth;
         int h = bmp.PixelHeight;
         int[] p = bmp.Pixels;
         byte[] result = new byte[BufferStrideByteARGB * w * h];

         // Copy pixels to buffer
         for (int i = offset, j = 0; i < count; i++, j += BufferStrideByteARGB)
         {
            int color = p[i];
            result[j + 0] = (byte)(color >> 24); // A
            result[j + 1] = (byte)(color >> 16); // R
            result[j + 2] = (byte)(color >> 8);  // G 
            result[j + 3] = (byte)(color);       // B
         }

         return result;
      }

      /// <summary>
      /// Copies the Pixels from the WriteableBitmap into a ARGB byte array.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="count">The number of pixels to copy.</param>
      /// <returns>The color buffer as byte ARGB values.</returns>
      public static byte[] ToByteArray(this WriteableBitmap bmp, int count)
      {
         return bmp.ToByteArray(0, count);
      }

      /// <summary>
      /// Copies all the Pixels from the WriteableBitmap into a ARGB byte array.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <returns>The color buffer as byte ARGB values.</returns>
      public static byte[] ToByteArray(this WriteableBitmap bmp)
      {
         return bmp.ToByteArray(0, bmp.Pixels.Length);
      }

      /// <summary>
      /// Copies color information from an ARGB byte array into the WriteableBitmap starting at a specific buffer index.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="offset">The starting index in the buffer.</param>
      /// <param name="count">The number of bytes to copy from the buffer.</param>
      /// <param name="buffer">The color buffer as byte ARGB values.</param>
      public static void FromByteArray(this WriteableBitmap bmp, byte[] buffer, int offset, int count)
      {
         // Init buffer
         int w = bmp.PixelWidth;
         int h = bmp.PixelHeight;
         int[] p = bmp.Pixels;

         // Copy pixels from buffer
         for (int i = 0, j = offset; j < count; i++, j += BufferStrideByteARGB)
         {
            p[i] = (buffer[j + 0] << 24) // A
                 | (buffer[j + 1] << 16) // R
                 | (buffer[j + 2] << 8)  // G
                 | buffer[j + 3];       // B
         }
      }

      /// <summary>
      /// Copies color information from an ARGB byte array into the WriteableBitmap.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="count">The number of bytes to copy from the buffer.</param>
      /// <param name="buffer">The color buffer as byte ARGB values.</param>
      public static void FromByteArray(this WriteableBitmap bmp, byte[] buffer, int count)
      {
         bmp.FromByteArray(buffer, 0, count);
      }

      /// <summary>
      /// Copies all the color information from an ARGB byte array into the WriteableBitmap.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="buffer">The color buffer as byte ARGB values.</param>
      public static void FromByteArray(this WriteableBitmap bmp, byte[] buffer)
      {
         bmp.FromByteArray(buffer, 0, buffer.Length);
      }

      #endregion

      #endregion
   }
}