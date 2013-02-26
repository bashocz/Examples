using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;

namespace Plochy
{
    public static class Templates
    {
        public static Mesh GetAxis()
        {
            Mesh mesh = new Mesh();

            mesh.AddPoint(new Point3D(-20, 0, 0));
            mesh.AddPoint(new Point3D(20, 0, 0));
            mesh.AddPoint(new Point3D(0, -20, 0));
            mesh.AddPoint(new Point3D(0, 20, 0));
            mesh.AddPoint(new Point3D(0, 0, -20));
            mesh.AddPoint(new Point3D(0, 0, 20));

            mesh.AddEdge(new Edge(mesh.PointList[0], mesh.PointList[1], mesh.ColorAxisX));
            mesh.AddEdge(new Edge(mesh.PointList[2], mesh.PointList[3], mesh.ColorAxisY));
            mesh.AddEdge(new Edge(mesh.PointList[4], mesh.PointList[5], mesh.ColorAxisZ));

            return mesh;
        }

        public static Mesh GetGrid()
        {
            Mesh mesh = new Mesh();

            for (int idx = 1; idx < 21; idx++)
            {
                Color color = mesh.ColorGridFine;
                if ((idx % 10) == 0)
                    color = mesh.ColorGrid;

                mesh.AddPoint(new Point3D(idx, -20, 0));
                mesh.AddPoint(new Point3D(idx, 20, 0));
                mesh.AddEdge(new Edge(mesh.PointList[mesh.PointList.Count - 2], mesh.PointList[mesh.PointList.Count - 1], color));
                mesh.AddPoint(new Point3D(-idx, -20, 0));
                mesh.AddPoint(new Point3D(-idx, 20, 0));
                mesh.AddEdge(new Edge(mesh.PointList[mesh.PointList.Count - 2], mesh.PointList[mesh.PointList.Count - 1], color));
                mesh.AddPoint(new Point3D(-20, idx, 0));
                mesh.AddPoint(new Point3D(20, idx, 0));
                mesh.AddEdge(new Edge(mesh.PointList[mesh.PointList.Count - 2], mesh.PointList[mesh.PointList.Count - 1], color));
                mesh.AddPoint(new Point3D(-20, -idx, 0));
                mesh.AddPoint(new Point3D(20, -idx, 0));
                mesh.AddEdge(new Edge(mesh.PointList[mesh.PointList.Count - 2], mesh.PointList[mesh.PointList.Count - 1], color));
            }

            return mesh;
        }

        public static Point3D[,] CreateControlPoint1()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-3, -3, 0);
            pointArray[0, 1] = new Point3D(-3, -1, 0);
            pointArray[0, 2] = new Point3D(-3, 1, 0);
            pointArray[0, 3] = new Point3D(-3, 3, 0);
            pointArray[1, 0] = new Point3D(-1, -3, 0);
            pointArray[1, 1] = new Point3D(-1, -1, 0);
            pointArray[1, 2] = new Point3D(-1, 1, 0);
            pointArray[1, 3] = new Point3D(-1, 3, 0);
            pointArray[2, 0] = new Point3D(1, -3, 0);
            pointArray[2, 1] = new Point3D(1, -1, 0);
            pointArray[2, 2] = new Point3D(1, 1, 0);
            pointArray[2, 3] = new Point3D(1, 3, 0);
            pointArray[3, 0] = new Point3D(3, -3, 0);
            pointArray[3, 1] = new Point3D(3, -1, 0);
            pointArray[3, 2] = new Point3D(3, 1, 0);
            pointArray[3, 3] = new Point3D(3, 3, 0);
            return pointArray;
        }

        public static Point3D[,] CreateControlPoint2()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-3, -3, 0);
            pointArray[0, 1] = new Point3D(-3, -1, 0);
            pointArray[0, 2] = new Point3D(-3, 1, 0);
            pointArray[0, 3] = new Point3D(-3, 3, 0);
            pointArray[1, 0] = new Point3D(-1, -3, 0);
            pointArray[1, 1] = new Point3D(-1, -1, 1);
            pointArray[1, 2] = new Point3D(-1, 1, 0);
            pointArray[1, 3] = new Point3D(-1, 3, 0);
            pointArray[2, 0] = new Point3D(1, -3, 0);
            pointArray[2, 1] = new Point3D(1, -1, 0);
            pointArray[2, 2] = new Point3D(1, 1, -1);
            pointArray[2, 3] = new Point3D(1, 3, 0);
            pointArray[3, 0] = new Point3D(3, -3, 0);
            pointArray[3, 1] = new Point3D(3, -1, 0);
            pointArray[3, 2] = new Point3D(3, 1, 0);
            pointArray[3, 3] = new Point3D(3, 3, 0);
            return pointArray;
        }

        public static Point3D[,] CreateControlPoint3()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-3, -3, 0);
            pointArray[0, 1] = new Point3D(-3, -1, 0);
            pointArray[0, 2] = new Point3D(-3, 1, 0);
            pointArray[0, 3] = new Point3D(-3, 3, 0);
            pointArray[1, 0] = new Point3D(-1, -3, 0);
            pointArray[1, 1] = new Point3D(-1, -1, 2);
            pointArray[1, 2] = new Point3D(-1, 1, 2);
            pointArray[1, 3] = new Point3D(-1, 3, 0);
            pointArray[2, 0] = new Point3D(1, -3, 0);
            pointArray[2, 1] = new Point3D(1, -1, 2);
            pointArray[2, 2] = new Point3D(1, 1, 2);
            pointArray[2, 3] = new Point3D(1, 3, 0);
            pointArray[3, 0] = new Point3D(3, -3, 0);
            pointArray[3, 1] = new Point3D(3, -1, 0);
            pointArray[3, 2] = new Point3D(3, 1, 0);
            pointArray[3, 3] = new Point3D(3, 3, 0);
            return pointArray;
        }

        public static Point3D[,] CreateControlPoint4()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-3, -1, -1);
            pointArray[0, 1] = new Point3D(-3, -1, 1);
            pointArray[0, 2] = new Point3D(-3, 1, 1);
            pointArray[0, 3] = new Point3D(-3, 1, -1);
            pointArray[1, 0] = new Point3D(-1, -1, -1);
            pointArray[1, 1] = new Point3D(-1, -1, 1);
            pointArray[1, 2] = new Point3D(-1, 1, 1);
            pointArray[1, 3] = new Point3D(-1, 1, -1);
            pointArray[2, 0] = new Point3D(1, -1, -1);
            pointArray[2, 1] = new Point3D(1, -1, 1);
            pointArray[2, 2] = new Point3D(1, 1, 1);
            pointArray[2, 3] = new Point3D(1, 1, -1);
            pointArray[3, 0] = new Point3D(3, -1, -1);
            pointArray[3, 1] = new Point3D(3, -1, 1);
            pointArray[3, 2] = new Point3D(3, 1, 1);
            pointArray[3, 3] = new Point3D(3, 1, -1);
            return pointArray;
        }

        public static Point3D[,] CreateControlPoint5()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-2.5, -2.5, 3);
            pointArray[0, 1] = new Point3D(-2.5, 1.5, -0.5);
            pointArray[0, 2] = new Point3D(-2.5, 2, -0.5);
            pointArray[0, 3] = new Point3D(-2.5, 2.5, -0.5);
            pointArray[1, 0] = new Point3D(1.5, -2.5, 0.5);
            pointArray[1, 1] = new Point3D(-1, -1, 0);
            pointArray[1, 2] = new Point3D(-1, 1, 0);
            pointArray[1, 3] = new Point3D(-2, 2.5, -0.5);
            pointArray[2, 0] = new Point3D(2, -2.5, 0.5);
            pointArray[2, 1] = new Point3D(1, -1, 0);
            pointArray[2, 2] = new Point3D(1, 1, 0);
            pointArray[2, 3] = new Point3D(-1.5, 2.5, -0.5);
            pointArray[3, 0] = new Point3D(2.5, -2.5, 0.5);
            pointArray[3, 1] = new Point3D(2.5, -2, 0.5);
            pointArray[3, 2] = new Point3D(2.5, -1.5, 0.5);
            pointArray[3, 3] = new Point3D(2.5, 2.5, -3);
            return pointArray;
        }

        public static Point3D[,] CreateControlPoint6()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-1.5, -1.5, -1);
            pointArray[0, 1] = new Point3D(-2, -0.5, -1);
            pointArray[0, 2] = new Point3D(-2, 0.5, -1);
            pointArray[0, 3] = new Point3D(-1.5, 1.5, -1);
            pointArray[1, 0] = new Point3D(-0.5, -2, -1);
            pointArray[1, 1] = new Point3D(-4, -4, 1);
            pointArray[1, 2] = new Point3D(-4, 4, 1);
            pointArray[1, 3] = new Point3D(-0.5, 2, -1);
            pointArray[2, 0] = new Point3D(0.5, -2, -1);
            pointArray[2, 1] = new Point3D(4, -4, 1);
            pointArray[2, 2] = new Point3D(4, 4, 1);
            pointArray[2, 3] = new Point3D(0.5, 2, -1);
            pointArray[3, 0] = new Point3D(1.5, -1.5, -1);
            pointArray[3, 1] = new Point3D(2, -0.5, -1);
            pointArray[3, 2] = new Point3D(2, 0.5, -1);
            pointArray[3, 3] = new Point3D(1.5, 1.5, -1);
            return pointArray;
        }

        public static Point3D[,] CreateControlPoint7()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-3, -3, -1);
            pointArray[0, 1] = new Point3D(-3, -1, -1);
            pointArray[0, 2] = new Point3D(-3, 1, 1);
            pointArray[0, 3] = new Point3D(-3, 3, 1);
            pointArray[1, 0] = new Point3D(-1, -3, -1);
            pointArray[1, 1] = new Point3D(-0.2, -0.2, 2);
            pointArray[1, 2] = new Point3D(-0.2, 0.2, -2);
            pointArray[1, 3] = new Point3D(-1, 3, 1);
            pointArray[2, 0] = new Point3D(1, -3, 1);
            pointArray[2, 1] = new Point3D(0.2, -0.2, -2);
            pointArray[2, 2] = new Point3D(0.2, 0.2, 2);
            pointArray[2, 3] = new Point3D(1, 3, -1);
            pointArray[3, 0] = new Point3D(3, -3, 1);
            pointArray[3, 1] = new Point3D(3, -1, 1);
            pointArray[3, 2] = new Point3D(3, 1, -1);
            pointArray[3, 3] = new Point3D(3, 3, -1);
            return pointArray;
        }

        public static Point3D[,] CreateControlPoint8()
        {
            Point3D[,] pointArray = new Point3D[4, 4];
            pointArray[0, 0] = new Point3D(-3, -3, -3);
            pointArray[0, 1] = new Point3D(-3, -1, 3);
            pointArray[0, 2] = new Point3D(-3, 1, 3);
            pointArray[0, 3] = new Point3D(-3, 3, -3);
            pointArray[1, 0] = new Point3D(-1, -3, 3);
            pointArray[1, 1] = new Point3D(-1, -1, -2);
            pointArray[1, 2] = new Point3D(-1, 1, -2);
            pointArray[1, 3] = new Point3D(-1, 3, 3);
            pointArray[2, 0] = new Point3D(1, -3, 3);
            pointArray[2, 1] = new Point3D(1, -1, -2);
            pointArray[2, 2] = new Point3D(1, 1, -2);
            pointArray[2, 3] = new Point3D(1, 3, 3);
            pointArray[3, 0] = new Point3D(3, -3, -3);
            pointArray[3, 1] = new Point3D(3, -1, 3);
            pointArray[3, 2] = new Point3D(3, 1, 3);
            pointArray[3, 3] = new Point3D(3, 3, -3);
            return pointArray;
        }

        public static Bezier GetBezier(int index)
        {
            switch (index)
            {
                case 2:
                    return new Bezier(CreateControlPoint2());
                case 3:
                    return new Bezier(CreateControlPoint3());
                case 4:
                    return new Bezier(CreateControlPoint4());
                case 5:
                    return new Bezier(CreateControlPoint5(), 16);
                case 6:
                    return new Bezier(CreateControlPoint6(), 16);
                case 7:
                    return new Bezier(CreateControlPoint7(), 16);
                case 8:
                    return new Bezier(CreateControlPoint8(), 16);
                default:
                    return new Bezier(CreateControlPoint1());
            }
        }

        public static Bezier GetBezier(Surface surface)
        {
            if (surface != null)
            {
                return new Bezier(surface.ControlPointArray, surface.Softness);
            }
            return null;
        }

        public static CoonsBspline GetCoons(int index)
        {
            switch (index)
            {
                case 2:
                    return new CoonsBspline(CreateControlPoint2());
                case 3:
                    return new CoonsBspline(CreateControlPoint3());
                case 4:
                    return new CoonsBspline(CreateControlPoint4());
                case 5:
                    return new CoonsBspline(CreateControlPoint5(), 16);
                case 6:
                    return new CoonsBspline(CreateControlPoint6(), 16);
                case 7:
                    return new CoonsBspline(CreateControlPoint7(), 16);
                case 8:
                    return new CoonsBspline(CreateControlPoint8(), 16);
                default:
                    return new CoonsBspline(CreateControlPoint1());
            }
        }
        public static CoonsBspline GetCoons(Surface surface)
        {
            if (surface != null)
            {
                return new CoonsBspline(surface.ControlPointArray, surface.Softness);
            }
            return null;
        }
    }
}
