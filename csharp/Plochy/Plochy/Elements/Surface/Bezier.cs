using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;

namespace Plochy
{
    public class Bezier : Surface
    {
        public Bezier(Point3D[,] pointArray)
            : this(pointArray, 8) { }

        public Bezier(Point3D[,] pointArray, int softness)
            : base(pointArray, softness) { }

        private double[] GetVector(double t)
        {
            double[] tm = new double[4];
            tm[0] = (1 - t) * (1 - t) * (1 - t);
            tm[1] = 3 * t * (1 - t) * (1 - t);
            tm[2] = 3 * t * t * (1 - t);
            tm[3] = t * t * t;
            return tm;
        }

        protected override double GetCoord(double[,] m, double u, double w)
        {
            double[] um = GetVector(u);
            double[] wm = GetVector(w);

            double[] temp = new double[4];

            for (int x = 0; x < 4; x++)
            {
                temp[x] = 0;
                for (int y = 0; y < 4; y++)
                    temp[x] += um[y] * m[x, y];
            }

            double value = 0;
            for (int x = 0; x < 4; x++)
                value += temp[x] * wm[x];

            return value;
        }
    }
}
