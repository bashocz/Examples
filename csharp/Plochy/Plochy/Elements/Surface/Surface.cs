using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;

namespace Plochy
{
    public abstract class Surface : Mesh
    {
        private readonly Point3D[,] mp;
        private readonly double[,] mx;
        private readonly double[,] my;
        private readonly double[,] mz;

        private int softness;

        public Surface()
            : base()
        {
            mp = new Point3D[4, 4];
            mx = new double[4, 4];
            my = new double[4, 4];
            mz = new double[4, 4];

            softness = 8;
        }

        public Surface(Point3D[,] pointArray, int softness)
            : this()
        {
            this.softness = softness;

            if ((pointArray.GetLength(0) != 4) || (pointArray.GetLength(1) != 4))
                throw new ArgumentOutOfRangeException();

            for (int x = 0; x < 4; x++)
                for (int y = 0; y < 4; y++)
                {
                    Point3DVisible point = new Point3DVisible(pointArray[x, y].X, pointArray[x, y].Y, pointArray[x, y].Z, ColorPoint);
                    mp[x,y] = point;
                    AddPoint(point);
                    if (y > 0)
                        AddEdge(new Edge(mp[x, y - 1], mp[x, y], ColorControlEdgeVertical));
                    if (x > 0)
                        AddEdge(new Edge(mp[x - 1, y], mp[x, y], ColorControlEdgeHorizontal));
                }

            CalculateSurface();
        }

        protected abstract double GetCoord(double[,] m, double u, double w);

        private Point3D GetPoint(double u, double w)
        {
            return new Point3D(GetCoord(mx, u, w), GetCoord(my, u, w), GetCoord(mz, u, w));
        }

        private void ClearSurface()
        {
            List<Point3D> deletePointList = new List<Point3D>();
            foreach (Point3D p3D in PointList)
                if (!(p3D is Point3DVisible))
                    deletePointList.Add(p3D);
            foreach (Point3D p3D in deletePointList)
                DeletePoint(p3D);
        }

        private void CalculateSurface()
        {
            ClearSurface();

            for (int x = 0; x < 4; x++)
                for (int y = 0; y < 4; y++)
                {
                    mx[x, y] = mp[x, y].X;
                    my[x, y] = mp[x, y].Y;
                    mz[x, y] = mp[x, y].Z;
                }

            Point3D[,] pointArray = new Point3D[softness, softness];
            for (int x = 0; x < softness; x++)
                for (int y = 0; y < softness; y++)
                {
                    pointArray[x, y] = GetPoint((double)x / (double)(softness - 1), (double)y / (double)(softness - 1));
                    AddPoint(pointArray[x, y]);
                    if (y > 0)
                        AddEdge(new Edge(pointArray[x, y - 1], pointArray[x, y], ColorSurfaceEdge));
                    if (x > 0)
                        AddEdge(new Edge(pointArray[x - 1, y], pointArray[x, y], ColorSurfaceEdge));
                }
        }

        public override void ChangeSelected(double x, double y, double z)
        {
            base.ChangeSelected(x, y, z);
            CalculateSurface();
        }

        public Point3D[,] ControlPointArray
        {
            get { return mp; }
        }

        public int Softness
        {
            get { return softness; }
            set
            {
                if ((value < 2) || (value > 32))
                    throw new ArgumentOutOfRangeException();
                if (value != softness)
                {
                    softness = value;
                    CalculateSurface();
                    NotifyPropertyChanged("Softness");
                }
            }
        }
    }
}
