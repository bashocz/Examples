using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Filter
{
    internal class Kernel
    {
        #region public fields

        public int R;
        public double[,] Matrix;

        #endregion

        #region constructors

        public Kernel(double sigma)
        {
            MakeKernel(sigma);
        }

        #endregion

        #region construct kernel methods

        private void MakeKernel(double sigma)
        {
            R = (int)Math.Ceiling(2 * sigma);
            int size = 2 * R + 1;
            Matrix = new double[size, size];

            if (size == 1)
            {
                Matrix[0, 0] = 1;
                return;
            }

            double sigma22 = 2 * sigma * sigma;
            double sigma2Pi2 = 2 * Math.PI * sigma * sigma;

            double total = 0;
            for (int i = -R; i <= R; i++)
                for (int j = -R; j <= R; j++)
                {
                    double value = (double)Math.Exp(-(i * i + j * j) / sigma22) / sigma2Pi2;
                    Matrix[i + R, j + R] = value;
                    total += value;
                }

            for (int i = -R; i <= R; i++)
                for (int j = -R; j <= R; j++)
                    Matrix[i + R, j + R] /= total;
        }

        #endregion
    }
}
