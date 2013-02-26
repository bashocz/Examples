using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Filter
{
    public class GaussianFilter
    {
        #region convolution methods

        private byte Convolution(int i, int j, int width, int height, byte[,] pixels, Kernel kernel)
        {
            double sum = 0;
            for (int k = -kernel.R; k <= kernel.R; k++)
                for (int l = -kernel.R; l <= kernel.R; l++)
                    sum += kernel.Matrix[k + kernel.R, l + kernel.R] * pixels[GetPixelIndex(i + k, width), GetPixelIndex(j + l, height)];
            return (byte)Math.Round(sum);
        }

        private int GetPixelIndex(int i, int max)
        {
            if (i < 0)
                return Math.Abs(i);
            else if (i >= max)
                return max - Math.Abs(i - max + 1);
            return i;
        }

        #endregion

        #region public method

        public void Filter(int width, int height, byte[,] pixels, double sigma)
        {
            Kernel kernel = new Kernel(sigma);
            byte[,] filter = new byte[width, height];
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                    filter[i, j] = Convolution(i, j, width, height, pixels, kernel);
            for (int j = 0; j < height; j++)
                for (int i = 0; i < width; i++)
                    pixels[i, j] = filter[i, j];
        }

        #endregion
    }
}
