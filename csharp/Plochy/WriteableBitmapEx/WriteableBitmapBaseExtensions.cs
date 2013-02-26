#region Header
//
//   Project:           WriteableBitmapEx - Silverlight WriteableBitmap extensions
//   Description:       Collection of draw extension methods for the Silverlight WriteableBitmap class.
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
   /// Collection of draw extension methods for the Silverlight WriteableBitmap class.
   /// </summary>
   public static partial class WriteableBitmapExtensions
   {
      #region Fields

      private const float PreMultiplyFactor = 1 / 255f;

      #endregion

      #region Methods

      #region General

      /// <summary>
      /// Fills the whole WriteableBitmap with a color.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="color">The color used for filling.</param>
      public static void Clear(this WriteableBitmap bmp, Color color)
      {
         int col =  (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B;
         int[] pixels = bmp.Pixels;
         int pixelCount = pixels.Length;
         for (int i = 0; i < pixelCount; i++)
         {
            pixels[i] = col;
         }
      }

      /// <summary>
      /// Fills the whole WriteableBitmap with an empty color (0).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      public static void Clear(this WriteableBitmap bmp)
      {
         Array.Clear(bmp.Pixels, 0, bmp.Pixels.Length);
      }

      #endregion

      #region SetPixel

      #region Without alpha

      /// <summary>
      /// Sets the color of the pixel using a precalculated index (faster).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="index">The coordinate index.</param>
      /// <param name="r">The red value of the color.</param>
      /// <param name="g">The green value of the color.</param>
      /// <param name="b">The blue value of the color.</param>
      public static void SetPixeli(this WriteableBitmap bmp, int index, byte r, byte g, byte b)
      {
         bmp.Pixels[index] = (255 << 24) | (r << 16) | (g << 8) | b;
      }

      /// <summary>
      /// Sets the color of the pixel.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x">The x coordinate (row).</param>
      /// <param name="y">The y coordinate (column).</param>
      /// <param name="r">The red value of the color.</param>
      /// <param name="g">The green value of the color.</param>
      /// <param name="b">The blue value of the color.</param>
      public static void SetPixel(this WriteableBitmap bmp, int x, int y, byte r, byte g, byte b)
      {
         bmp.Pixels[y * bmp.PixelWidth + x] = (255 << 24) | (r << 16) | (g << 8) | b;
      }

      #endregion

      #region With alpha

      /// <summary>
      /// Sets the color of the pixel including the alpha value and using a precalculated index (faster).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="index">The coordinate index.</param>
      /// <param name="a">The alpha value of the color.</param>
      /// <param name="r">The red value of the color.</param>
      /// <param name="g">The green value of the color.</param>
      /// <param name="b">The blue value of the color.</param>
      public static void SetPixeli(this WriteableBitmap bmp, int index, byte a, byte r, byte g, byte b)
      {
         float ai = a * PreMultiplyFactor;
         bmp.Pixels[index] = (a << 24) | ((byte)(r * ai) << 16) | ((byte)(g * ai) << 8) | (byte)(b * ai);
      }

      /// <summary>
      /// Sets the color of the pixel including the alpha value.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x">The x coordinate (row).</param>
      /// <param name="y">The y coordinate (column).</param>
      /// <param name="a">The alpha value of the color.</param>
      /// <param name="r">The red value of the color.</param>
      /// <param name="g">The green value of the color.</param>
      /// <param name="b">The blue value of the color.</param>
      public static void SetPixel(this WriteableBitmap bmp, int x, int y, byte a, byte r, byte g, byte b)
      {
         float ai = a * PreMultiplyFactor;
         bmp.Pixels[y * bmp.PixelWidth + x] = (a << 24) | ((byte)(r * ai) << 16) | ((byte)(g * ai) << 8) | (byte)(b * ai);
      }

      #endregion

      #region With System.Windows.Media.Color

      /// <summary>
      /// Sets the color of the pixel using a precalculated index (faster).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="index">The coordinate index.</param>
      /// <param name="color">The color.</param>
      public static void SetPixeli(this WriteableBitmap bmp, int index, Color color)
      {
         float ai = color.A * PreMultiplyFactor;
         bmp.Pixels[index] = (color.A << 24) | ((byte)(color.R * ai) << 16) | ((byte)(color.G * ai) << 8) | (byte)(color.B * ai);
      }

      /// <summary>
      /// Sets the color of the pixel.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x">The x coordinate (row).</param>
      /// <param name="y">The y coordinate (column).</param>
      /// <param name="color">The color.</param>
      public static void SetPixel(this WriteableBitmap bmp, int x, int y, Color color)
      {
         float ai = color.A * PreMultiplyFactor;
         bmp.Pixels[y * bmp.PixelWidth + x] = (color.A << 24) | ((byte)(color.R * ai) << 16) | ((byte)(color.G * ai) << 8) | (byte)(color.B * ai);
      }

      /// <summary>
      /// Sets the color of the pixel using an extra alpha value and a precalculated index (faster).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="index">The coordinate index.</param>
      /// <param name="a">The alpha value of the color.</param>
      /// <param name="color">The color.</param>
      public static void SetPixeli(this WriteableBitmap bmp, int index, byte a, Color color)
      {
         float ai = a * PreMultiplyFactor;
         bmp.Pixels[index] = (a << 24) | ((byte)(color.R * ai) << 16) | ((byte)(color.G * ai) << 8) | (byte)(color.B * ai);
      }

      /// <summary>
      /// Sets the color of the pixel using an extra alpha value.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x">The x coordinate (row).</param>
      /// <param name="y">The y coordinate (column).</param>
      /// <param name="a">The alpha value of the color.</param>
      /// <param name="color">The color.</param>
      public static void SetPixel(this WriteableBitmap bmp, int x, int y, byte a, Color color)
      {
         float ai = a * PreMultiplyFactor;
         bmp.Pixels[y * bmp.PixelWidth + x] = (a << 24) | ((byte)(color.R * ai) << 16) | ((byte)(color.G * ai) << 8) | (byte)(color.B * ai);
      }

      /// <summary>
      /// Sets the color of the pixel using a precalculated index (faster).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="index">The coordinate index.</param>
      /// <param name="color">The color.</param>
      public static void SetPixeli(this WriteableBitmap bmp, int index, int color)
      {
         bmp.Pixels[index] = color;
      }

      /// <summary>
      /// Sets the color of the pixel.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x">The x coordinate (row).</param>
      /// <param name="y">The y coordinate (column).</param>
      /// <param name="color">The color.</param>
      public static void SetPixel(this WriteableBitmap bmp, int x, int y, int color)
      {
         bmp.Pixels[y * bmp.PixelWidth + x] = color;
      }

      #endregion

      #endregion      
      
      #endregion
   }
}