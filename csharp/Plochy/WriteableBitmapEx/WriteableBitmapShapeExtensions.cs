﻿#region Header
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
      #region Methods

      #region DrawLine

      /// <summary>
      /// Draws a colored line by connecting two points using a DDA algorithm (Digital Differential Analyzer).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the start point.</param>
      /// <param name="y1">The y-coordinate of the start point.</param>
      /// <param name="x2">The x-coordinate of the end point.</param>
      /// <param name="y2">The y-coordinate of the end point.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawLineDDA(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, Color color)
      {
         bmp.DrawLineDDA(x1, y1, x2, y2, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// Draws a colored line by connecting two points using a DDA algorithm (Digital Differential Analyzer).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the start point.</param>
      /// <param name="y1">The y-coordinate of the start point.</param>
      /// <param name="x2">The x-coordinate of the end point.</param>
      /// <param name="y2">The y-coordinate of the end point.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawLineDDA(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int color)
      {
         // Use refs for faster access (really important!) speeds up a lot!
         int w = bmp.PixelWidth;
         int[] pixels = bmp.Pixels;

         // Distance start and end point
         int dx = x2 - x1;
         int dy = y2 - y1;

         // Determine slope (absoulte value)
         int len = dy >= 0 ? dy : -dy;
         int lenx = dx >= 0 ? dx : -dx;
         if (lenx > len)
         {
            len = lenx;
         }

         // Prevent divison by zero
         if (len != 0)
         {
            // Init steps and start
            float incx = dx / (float)len;
            float incy = dy / (float)len;
            float x = x1;
            float y = y1;

            // Walk the line!
            for (int i = 0; i < len; i++)
            {
               pixels[(int)y * w + (int)x] = color;
               x += incx;
               y += incy;
            }
         }
      }

      /// <summary>
      /// Draws a colored line by connecting two points using an optimized DDA by Nikola 
      /// (http://nokola.com/blog/post/2009/11/06/Faster-DrawLine%28%29-in-Silverlight-%28400000-linessec%29.aspx).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the start point.</param>
      /// <param name="y1">The y-coordinate of the start point.</param>
      /// <param name="x2">The x-coordinate of the end point.</param>
      /// <param name="y2">The y-coordinate of the end point.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawLine(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, Color color)
      {
         bmp.DrawLine(x1, y1, x2, y2, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// Draws a colored line by connecting two points using an optimized DDA by Nikola 
      /// (http://nokola.com/blog/post/2009/11/06/Faster-DrawLine%28%29-in-Silverlight-%28400000-linessec%29.aspx).
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the start point.</param>
      /// <param name="y1">The y-coordinate of the start point.</param>
      /// <param name="x2">The x-coordinate of the end point.</param>
      /// <param name="y2">The y-coordinate of the end point.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawLine(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int color)
      {
         // Use refs for faster access (really important!) speeds up a lot!
         int w = bmp.PixelWidth;
         int[] pixels = bmp.Pixels;

         // Distance start and end point
         int dx = x2 - x1;
         int dy = y2 - y1;

         const int PRECISION_SHIFT = 8;
         const int PRECISION_VALUE = 1 << PRECISION_SHIFT;

         // Determine slope (absoulte value)
         int lenX, lenY;
         int incy1;
         if (dy >= 0)
         {
            incy1 = PRECISION_VALUE;
            lenY = dy;
         }
         else
         {
            incy1 = -PRECISION_VALUE;
            lenY = -dy;
         }

         int incx1;
         if (dx >= 0)
         {
            incx1 = 1;
            lenX = dx;
         }
         else
         {
            incx1 = -1;
            lenX = -dx;
         }

         if (lenX > lenY)
         { // x increases by +/- 1
            // Init steps and start
            int incy = (dy << PRECISION_SHIFT) / lenX;
            int y = y1 << PRECISION_SHIFT;

            // Walk the line!
            for (int i = 0; i < lenX; i++)
            {
               pixels[(y >> PRECISION_SHIFT) * w + x1] = color;
               x1 += incx1;
               y += incy;
            }
         }
         else
         { // since y increases by +/-1, we can safely add (*h) before the for() loop, since there is no fractional value for y
            // Prevent divison by zero
            if (lenY == 0)
            {
               return;
            }

            // Init steps and start
            int incx = (dx << PRECISION_SHIFT) / lenY;
            int index = (x1 + y1 * w) << PRECISION_SHIFT;

            // Walk the line!
            int inc = incy1 * w + incx;
            for (int i = 0; i < lenY; i++)
            {
               pixels[index >> PRECISION_SHIFT] = color;
               index += inc;
            }
         }
      }

      /// <summary>
      /// Draws a colored line by connecting two points using the Bresenham algorithm.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the start point.</param>
      /// <param name="y1">The y-coordinate of the start point.</param>
      /// <param name="x2">The x-coordinate of the end point.</param>
      /// <param name="y2">The y-coordinate of the end point.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawLineBresenham(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int color)
      {
         // Use refs for faster access (really important!) speeds up a lot!
         int w = bmp.PixelWidth;
         int[] pixels = bmp.Pixels;

         // Distance start and end point
         int dx = x2 - x1;
         int dy = y2 - y1;

         // Determine sign for direction x
         int incx = 0;
         if (dx < 0)
         {
            dx = -dx;
            incx = -1;
         }
         else if (dx > 0)
         {
            incx = 1;
         }

         // Determine sign for direction y
         int incy = 0;
         if (dy < 0)
         {
            dy = -dy;
            incy = -1;
         }
         else if (dy > 0)
         {
            incy = 1;
         }

         // Which gradient is larger
         int pdx, pdy, odx, ody, es, el;
         if (dx > dy)
         {
            pdx = incx;
            pdy = 0;
            odx = incx;
            ody = incy;
            es = dy;
            el = dx;
         }
         else
         {
            pdx = 0;
            pdy = incy;
            odx = incx;
            ody = incy;
            es = dx;
            el = dy;
         }

         // Init start
         int x = x1;
         int y = y1;
         int error = el >> 1;
         pixels[y * w + x] = color;

         // Walk the line!
         for (int i = 0; i < el; i++)
         {
            // Update error term
            error -= es;

            // Decide which coord to use
            if (error < 0)
            {
               error += el;
               x += odx;
               y += ody;
            }
            else
            {
               x += pdx;
               y += pdy;
            }

            // Set pixel
            pixels[y * w + x] = color;
         }
      }

      #endregion

      #region Draw Shapes
            
      /// <summary>
      /// Draws a polyline. Add the first point also at the end of the array if the line should be closed.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="points">The points of the polyline in x and y pairs, therefore the array is interpreted as (x1, y1, x2, y2, ..., xn, yn).</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawPolyline(this WriteableBitmap bmp, int[] points, Color color)
      {
         bmp.DrawPolyline(points, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// Draws a polyline. Add the first point also at the end of the array if the line should be closed.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="points">The points of the polyline in x and y pairs, therefore the array is interpreted as (x1, y1, x2, y2, ..., xn, yn).</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawPolyline(this WriteableBitmap bmp, int[] points, int color)
      {
         int x1 = points[0];
         int y1 = points[1];
         int x2, y2;
         for (int i = 2; i < points.Length; i+=2)
         {
            x2 = points[i    ];
            y2 = points[i + 1];
            bmp.DrawLine(x1, y1, x2, y2, color);
            x1 = x2;
            y1 = y2;
         }
      }

      /// <summary>
      /// Draws a triangle.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the 1st point.</param>
      /// <param name="y1">The y-coordinate of the 1st point.</param>
      /// <param name="x2">The x-coordinate of the 2nd point.</param>
      /// <param name="y2">The y-coordinate of the 2nd point.</param>
      /// <param name="x3">The x-coordinate of the 3rd point.</param>
      /// <param name="y3">The y-coordinate of the 3rd point.</param>
      /// <param name="color">The color.</param>
      public static void DrawTriangle(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int x3, int y3, Color color)
      {
         bmp.DrawTriangle(x1, y1, x2, y2, x3, y3, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// Draws a triangle.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the 1st point.</param>
      /// <param name="y1">The y-coordinate of the 1st point.</param>
      /// <param name="x2">The x-coordinate of the 2nd point.</param>
      /// <param name="y2">The y-coordinate of the 2nd point.</param>
      /// <param name="x3">The x-coordinate of the 3rd point.</param>
      /// <param name="y3">The y-coordinate of the 3rd point.</param>
      /// <param name="color">The color.</param>
      public static void DrawTriangle(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int x3, int y3, int color)
      {
         bmp.DrawLine(x1, y1, x2, y2, color);
         bmp.DrawLine(x2, y2, x3, y3, color);
         bmp.DrawLine(x3, y3, x1, y1, color);
      }

      /// <summary>
      /// Draws a quad.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the 1st point.</param>
      /// <param name="y1">The y-coordinate of the 1st point.</param>
      /// <param name="x2">The x-coordinate of the 2nd point.</param>
      /// <param name="y2">The y-coordinate of the 2nd point.</param>
      /// <param name="x3">The x-coordinate of the 3rd point.</param>
      /// <param name="y3">The y-coordinate of the 3rd point.</param>
      /// <param name="x4">The x-coordinate of the 4th point.</param>
      /// <param name="y4">The y-coordinate of the 4th point.</param>
      /// <param name="color">The color.</param>
      public static void DrawQuad(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, Color color)
      {
         bmp.DrawQuad(x1, y1, x2, y2, x3, y3, x4, y4, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// Draws a quad.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the 1st point.</param>
      /// <param name="y1">The y-coordinate of the 1st point.</param>
      /// <param name="x2">The x-coordinate of the 2nd point.</param>
      /// <param name="y2">The y-coordinate of the 2nd point.</param>
      /// <param name="x3">The x-coordinate of the 3rd point.</param>
      /// <param name="y3">The y-coordinate of the 3rd point.</param>
      /// <param name="x4">The x-coordinate of the 4th point.</param>
      /// <param name="y4">The y-coordinate of the 4th point.</param>
      /// <param name="color">The color.</param>
      public static void DrawQuad(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int color)
      {
         bmp.DrawLine(x1, y1, x2, y2, color);
         bmp.DrawLine(x2, y2, x3, y3, color);
         bmp.DrawLine(x3, y3, x4, y4, color);
         bmp.DrawLine(x4, y4, x1, y1, color);
      }

      /// <summary>
      /// Draws a rectangle.
      /// x2 has to be greater than x1 and y2 has to be greater than y1.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the bounding rectangle's left side.</param>
      /// <param name="y1">The y-coordinate of the bounding rectangle's top side.</param>
      /// <param name="x2">The x-coordinate of the bounding rectangle's right side.</param>
      /// <param name="y2">The y-coordinate of the bounding rectangle's bottom side.</param>
      /// <param name="color">The color.</param>
      public static void DrawRectangle(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, Color color)
      {
         bmp.DrawRectangle(x1, y1, x2, y2, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// Draws a rectangle.
      /// x2 has to be greater than x1 and y2 has to be greater than y1.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the bounding rectangle's left side.</param>
      /// <param name="y1">The y-coordinate of the bounding rectangle's top side.</param>
      /// <param name="x2">The x-coordinate of the bounding rectangle's right side.</param>
      /// <param name="y2">The y-coordinate of the bounding rectangle's bottom side.</param>
      /// <param name="color">The color.</param>
      public static void DrawRectangle(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int color)
      {
         // Use refs for faster access (really important!) speeds up a lot!
         int w = bmp.PixelWidth;
         int[] pixels = bmp.Pixels;

         int startY = y1 * w;
         int endY = y2 * w;

         int offset2 = endY + x1;
         int endOffset = startY + x2;
         int startYPlusX1 = startY + x1;

         // top and bottom horizontal scanlines
         for (int x = startYPlusX1; x <= endOffset; x++)
         {
            pixels[x] = color; // top horizontal line
            pixels[offset2] = color; // bottom horizontal line
            offset2++;
         }

         // offset2 == endY + x2

         // vertical scanlines
         endOffset = startYPlusX1 + w;
         offset2 -= w;

         for (int y = startY + x2 + w; y < offset2; y += w)
         {
            pixels[y] = color; // right vertical line
            pixels[endOffset] = color; // left vertical line
            endOffset += w;
         }
      }

      /// <summary>
      /// A Fast Bresenham Type Algorithm For Drawing Ellipses http://homepage.smc.edu/kennedy_john/belipse.pdf 
      /// x2 has to be greater than x1 and y2 has to be greater than y1.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the bounding rectangle's left side.</param>
      /// <param name="y1">The y-coordinate of the bounding rectangle's top side.</param>
      /// <param name="x2">The x-coordinate of the bounding rectangle's right side.</param>
      /// <param name="y2">The y-coordinate of the bounding rectangle's bottom side.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawEllipse(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, Color color)
      {
         bmp.DrawEllipse(x1, y1, x2, y2, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// A Fast Bresenham Type Algorithm For Drawing Ellipses http://homepage.smc.edu/kennedy_john/belipse.pdf 
      /// x2 has to be greater than x1 and y2 has to be greater than y1.
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="x1">The x-coordinate of the bounding rectangle's left side.</param>
      /// <param name="y1">The y-coordinate of the bounding rectangle's top side.</param>
      /// <param name="x2">The x-coordinate of the bounding rectangle's right side.</param>
      /// <param name="y2">The y-coordinate of the bounding rectangle's bottom side.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawEllipse(this WriteableBitmap bmp, int x1, int y1, int x2, int y2, int color)
      {
         // Calc center and radius
         int xr = (x2 - x1) >> 1;
         int yr = (y2 - y1) >> 1;
         int xc = x1 + xr;
         int yc = y1 + yr;
         bmp.DrawEllipseCentered(xc, yc, xr, yr, color);
      }

      /// <summary>
      /// A Fast Bresenham Type Algorithm For Drawing Ellipses http://homepage.smc.edu/kennedy_john/belipse.pdf
      /// It uses a different parameter representation than DrawEllipse().
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="xc">The x-coordinate of the ellipses center.</param>
      /// <param name="yc">The y-coordinate of the ellipses center.</param>
      /// <param name="xr">The radius of the ellipse in x-direction.</param>
      /// <param name="yr">The radius of the ellipse in y-direction.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawEllipseCentered(this WriteableBitmap bmp, int xc, int yc, int xr, int yr, Color color)
      {
         bmp.DrawEllipseCentered(xc, yc, xr, yr, (color.A << 24) | (color.R << 16) | (color.G << 8) | color.B);
      }

      /// <summary>
      /// A Fast Bresenham Type Algorithm For Drawing Ellipses http://homepage.smc.edu/kennedy_john/belipse.pdf 
      /// It uses a different parameter representation than DrawEllipse().
      /// </summary>
      /// <param name="bmp">The WriteableBitmap.</param>
      /// <param name="xc">The x-coordinate of the ellipses center.</param>
      /// <param name="yc">The y-coordinate of the ellipses center.</param>
      /// <param name="xr">The radius of the ellipse in x-direction.</param>
      /// <param name="yr">The radius of the ellipse in y-direction.</param>
      /// <param name="color">The color for the line.</param>
      public static void DrawEllipseCentered(this WriteableBitmap bmp, int xc, int yc, int xr, int yr, int color)
      {
         // Use refs for faster access (really important!) speeds up a lot!
         int w = bmp.PixelWidth;
         int[] pixels = bmp.Pixels;

         // Init vars
         int uh, lh;
         int x = xr;
         int y = 0;
         int xrSqTwo = (xr * xr) << 1;
         int yrSqTwo = (yr * yr) << 1;
         int xChg = yr * yr * (1 - (xr << 1));
         int yChg = xr * xr;
         int err = 0;
         int xStopping = yrSqTwo * xr;
         int yStopping = 0;

         // Draw first set of points counter clockwise where tangent line slope > -1.
         while (xStopping >= yStopping)
         {
            // Draw 4 quadrant points at once
            uh = (yc + y) * w;            // Upper half
            lh = (yc - y) * w;            // Lower half
            pixels[xc + x + uh] = color;  // Quadrant I
            pixels[xc - x + uh] = color;  // Quadrant II
            pixels[xc - x + lh] = color;  // Quadrant III
            pixels[xc + x + lh] = color;  // Quadrant IV

            y++;
            yStopping += xrSqTwo;
            err += yChg;
            yChg += xrSqTwo;
            if ((xChg + (err << 1)) > 0)
            {
               x--;
               xStopping -= yrSqTwo;
               err += xChg;
               xChg += yrSqTwo;
            }
         }

         // ReInit vars
         x = 0;
         y = yr;
         uh = (yc + y) * w;            // Upper half
         lh = (yc - y) * w;            // Lower half
         xChg = yr * yr;
         yChg = xr * xr * (1 - (yr << 1));
         err = 0;
         xStopping = 0;
         yStopping = xrSqTwo * yr;

         // Draw second set of points clockwise where tangent line slope < -1.
         while (xStopping <= yStopping)
         {
            // Draw 4 quadrant points at once
            pixels[xc + x + uh] = color;  // Quadrant I
            pixels[xc - x + uh] = color;  // Quadrant II
            pixels[xc - x + lh] = color;  // Quadrant III
            pixels[xc + x + lh] = color;  // Quadrant IV
            
            x++;
            xStopping += yrSqTwo;
            err += xChg;
            xChg += yrSqTwo;
            if ((yChg + (err << 1)) > 0)
            {
               y--;
               uh = (yc + y) * w;            // Upper half
               lh = (yc - y) * w;            // Lower half
               yStopping -= xrSqTwo;
               err += yChg;
               yChg += xrSqTwo;
            }
         }
      }

      #endregion
      
      #endregion
   }
}