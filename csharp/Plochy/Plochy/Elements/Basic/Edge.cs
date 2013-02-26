using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;

namespace Plochy
{
    public class Edge
    {
        private Edge()
        {
            Color = Colors.Transparent;
        }

        public Edge(Point3D startPoint, Point3D endPoint)
        {
            StartPoint = startPoint;
            EndPoint = endPoint;
        }

        public Edge(Point3D startPoint, Point3D endPoint, Color color)
            : this(startPoint, endPoint)
        {
            Color = color;
        }

        public Point3D StartPoint { get; private set; }
        public Point3D EndPoint { get; private set; }

        public Color Color { get; set; }
    }
}
