using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;

namespace Plochy
{
    public class Point3DVisible : Point3D
    {
        public Point3DVisible(double x, double y, double z, Color color)
            : base(x, y, z)
        {
            Color = color;
        }

        public Color Color { get; set; }
    }
}
