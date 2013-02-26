#region Header
//
//   Project:           WriteableBitmapEx - Silverlight WriteableBitmap extensions
//   Description:       Collection of blit (copy) extension methods for the Silverlight WriteableBitmap class.
//
//   Changed by:        $Author$
//   Changed on:        $Date$
//   Changed in:        $Revision$
//   Project:           $URL$
//   Id:                $Id$
//
//
//   Copyright © 2009 Bill Reiss, Rene Schulte and WriteableBitmapEx Contributors
//
//   This Software is weak copyleft open source. Please read the License.txt for details.
//
#endregion

namespace System.Windows.Media.Imaging
{
   /// <summary>
   /// Collection of blit (copy) extension methods for the Silverlight WriteableBitmap class.
   /// </summary>
   public static partial class WriteableBitmapExtensions
   {
      #region Enum

      /// <summary>
      /// The blending mode.
      /// </summary>
      public enum BlendMode
      {
         /// <summary>
         /// Alpha blendiing uses the alpha channel to combine the source and destination. 
         /// </summary>
         AlphaBlend,

         /// <summary>
         /// Additive blending adds the colors of the source and the destination.
         /// </summary>
         Additive,

         /// <summary>
         /// Subtractive blending subtracts the source color from the destination.
         /// </summary>
         Subtractive,

         /// <summary>
         /// No blending just copies the pixels from the source.
         /// </summary>
         None
      }

      #endregion
      
      #region Methods

      /// <summary>
      /// Copies (blits) the pixels from the WriteableBitmap source to the destination WriteableBitmap (this).
      /// </summary>
      /// <param name="bmp">The destination WriteableBitmap.</param>
      /// <param name="destRect">The rectangle that defines the destination region.</param>
      /// <param name="source">The source WriteableBitmap.</param>
      /// <param name="sourceRect">The rectangle that will be copied from the source to the destination.</param>
      /// <param name="BlendMode">The blending mode <see cref="BlendMode"/>.</param>
      public static void Blit(this WriteableBitmap bmp, Rect destRect, WriteableBitmap source, Rect sourceRect, BlendMode BlendMode)
      {
         Blit(bmp, destRect, source, sourceRect, Colors.White, BlendMode);
      }

      /// <summary>
      /// Copies (blits) the pixels from the WriteableBitmap source to the destination WriteableBitmap (this).
      /// </summary>
      /// <param name="bmp">The destination WriteableBitmap.</param>
      /// <param name="destRect">The rectangle that defines the destination region.</param>
      /// <param name="source">The source WriteableBitmap.</param>
      /// <param name="sourceRect">The rectangle that will be copied from the source to the destination.</param>
      public static void Blit(this WriteableBitmap bmp, Rect destRect, WriteableBitmap source, Rect sourceRect)
      {
         Blit(bmp, destRect, source, sourceRect, Colors.White, BlendMode.AlphaBlend);
      }

      /// <summary>
      /// Copies (blits) the pixels from the WriteableBitmap source to the destination WriteableBitmap (this).
      /// </summary>
      /// <param name="bmp">The destination WriteableBitmap.</param>
      /// <param name="destPosition">The destination position in the destination bitmap.</param>
      /// <param name="source">The source WriteableBitmap.</param>
      /// <param name="sourceRect">The rectangle that will be copied from the source to the destination.</param>
      /// <param name="color">If not Colors.White, will tint the source image. A partially transparent color and the image will be drawn partially transparent.</param>
      /// <param name="BlendMode">The blending mode <see cref="BlendMode"/>.</param>
      public static void Blit(this WriteableBitmap bmp, Point destPosition, WriteableBitmap source, Rect sourceRect, Color color, BlendMode BlendMode)
      {
         Rect destRect = new Rect(destPosition, new Size(sourceRect.Width, sourceRect.Height));
         Blit(bmp, destRect, source, sourceRect, color, BlendMode);
      }

      /// <summary>
      /// Copies (blits) the pixels from the WriteableBitmap source to the destination WriteableBitmap (this).
      /// </summary>
      /// <param name="bmp">The destination WriteableBitmap.</param>
      /// <param name="destRect">The rectangle that defines the destination region.</param>
      /// <param name="source">The source WriteableBitmap.</param>
      /// <param name="sourceRect">The rectangle that will be copied from the source to the destination.</param>
      /// <param name="color">If not Colors.White, will tint the source image. A partially transparent color and the image will be drawn partially transparent.</param>
      /// <param name="BlendMode">The blending mode <see cref="BlendMode"/>.</param>
      public static void Blit(this WriteableBitmap bmp, Rect destRect, WriteableBitmap source, Rect sourceRect, Color color, BlendMode BlendMode)
      {
         if (color.A == 0)
         {
            return;
         }
         int dw = (int)destRect.Width;
         int dh = (int)destRect.Height;
         int dpw = bmp.PixelWidth;
         int dph = bmp.PixelHeight;
         Rect intersect = new Rect(0, 0, dpw, dph);
         intersect.Intersect(destRect);
         if (intersect.IsEmpty)
         {
            return;
         }
         int sourceWidth = source.PixelWidth;

         int[] sourcePixels = source.Pixels;
         int[] destPixels = bmp.Pixels;
         int sourceLength = sourcePixels.Length;
         int destLength = destPixels.Length;
         int sourceIdx = -1;
         int px = (int)destRect.X;
         int py = (int)destRect.Y;
         int right = px + dw;
         int bottom = py + dh;
         int x;
         int y;
         int idx;
         double ii;
         double jj;
         int sr = 0;
         int sg = 0;
         int sb = 0;
         int dr, dg, db;
         int sourcePixel;
         int sa = 0;
         int da;
         int ca = color.A;
         int cr = color.R;
         int cg = color.G;
         int cb = color.B;
         bool tinted = color != Colors.White;
         double sdx = sourceRect.Width / destRect.Width;
         double sdy = sourceRect.Height / destRect.Height;
         int sourceStartX = (int)sourceRect.X;
         int sourceStartY = (int)sourceRect.Y;
         int lastii, lastjj;
         lastii = -1;
         lastjj = -1;
         jj = sourceStartY;
         y = py;
         for (int j = 0; j < dh; j++)
         {
            if (y >= 0 && y < dph)
            {
               ii = sourceStartX;
               idx = px + y * dpw;
               x = px;
               sourcePixel = sourcePixels[0];

               for (int i = 0; i < dw; i++)
               {
                  if (x >= 0 && x < dpw)
                  {
                     if ((int)ii != lastii || (int)jj != lastjj)
                     {
                        sourceIdx = (int)ii + (int)jj * sourceWidth;
                        if (sourceIdx >= 0 && sourceIdx < sourceLength)
                        {
							sourcePixel = sourcePixels[sourceIdx];
							sa = ((sourcePixel >> 24) & 0xff);
							sr = ((sourcePixel >> 16) & 0xff);
							sg = ((sourcePixel >> 8) & 0xff);
							sb = ((sourcePixel) & 0xff);
							if (tinted && sa != 0)
							{
								sa = (((sa * ca) * 0x8081) >> 23);
								sr = ((((((sr * cr) * 0x8081) >> 23) * ca) * 0x8081) >> 23);
								sg = ((((((sg * cg) * 0x8081) >> 23) * ca) * 0x8081) >> 23);
								sb = ((((((sb * cb) * 0x8081) >> 23) * ca) * 0x8081) >> 23);
								sourcePixel = (sa << 24) | (sr << 16) | (sg << 8) | sb;
							}
						}
                        else
                        {
                           sa = 0;
                        }
                     }
                     if (BlendMode == BlendMode.None)
                     {
                        destPixels[idx] = sourcePixel;
                     }
                     else if (sa > 0)
                     {
                        int destPixel = destPixels[idx];
                        da = ((destPixel >> 24) & 0xff);
                        if ((sa == 255 || da == 0) &&
                           BlendMode != BlendMode.Additive &&
                           BlendMode != BlendMode.Subtractive
                           )
                        {
                           destPixels[idx] = sourcePixel;
                        }
                        else
                        {
                           dr = ((destPixel >> 16) & 0xff);
                           dg = ((destPixel >> 8) & 0xff);
                           db = ((destPixel) & 0xff);
                           if (BlendMode == BlendMode.AlphaBlend)
                           {
							   destPixel = ((sa + (((da * (255 - sa)) * 0x8081) >> 23)) << 24) |
								   ((sr + (((dr * (255 - sa)) * 0x8081) >> 23)) << 16) |
								   ((sg + (((dg * (255 - sa)) * 0x8081) >> 23)) << 8) |
								   ((sb + (((db * (255 - sa)) * 0x8081) >> 23)));
						   }
                           else if (BlendMode == BlendMode.Additive)
                           {
							   int a = (255 <= sa + da) ? 255 : (sa + da);
							   destPixel = (a << 24) |
									(((a <= sr + dr) ? a : (sr + dr)) << 16) |
									(((a <= sg + dg) ? a : (sg + dg)) << 8) |
									(((a <= sb + db) ? a : (sb + db)));
                           }
                           else if (BlendMode == BlendMode.Subtractive)
                           {
							   int a = da;
							   destPixel = (a << 24) |
									(((sr >= dr) ? 0 : (sr - dr)) << 16) |
									(((sg >= dg) ? 0 : (sg - dg)) << 8) |
									(((sb >= db) ? 0 : (sb - db)));
                           }
                           destPixels[idx] = destPixel;
                        }
                     }
                  }
                  x++;
                  idx++;
                  ii += sdx;
               }
            }
            jj += sdy;
            y++;
         }
      }

      #endregion
   }
}