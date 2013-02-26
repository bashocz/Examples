using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;

namespace Plochy
{
    public class Point3D
    {
        public Point3D()
            : this(0, 0, 0) { }

        public Point3D(double x, double y, double z)
        {
            X = x;
            Y = y;
            Z = z;
        }

        public double X { get; set; }
        public double Y { get; set; }
        public double Z { get; set; }
    }
}
