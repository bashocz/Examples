using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using Kit3D.Windows.Controls;
using Kit3D.Windows.Media.Media3D;
using WebMech.WebMechService;

namespace WebMech
{
    public class VisualizeSurface
    {
        private readonly Viewport3D mainViewport;
        private readonly int surfaceSize;

        private readonly Vector3D light = new Vector3D(-1 / Math.Sqrt(14), -3 / Math.Sqrt(14), -2 / Math.Sqrt(14));

        private double xAngle;
        private double yAngle;

        public VisualizeSurface(Viewport3D mainViewport, int surfaceSize)
        {
            this.mainViewport = mainViewport;
            this.surfaceSize = surfaceSize;
        }

        /// <summary>
        /// Generates 3D points for visualization.
        /// </summary>
        /// <param name="model3D">A WebMech.Web.Model3DData that specifies
        /// data object of 3D model with basic statistic data and list of 3D points.</param>
        /// <returns>A Kit3D.Windows.Media.Media3D.Point3D that specifies
        /// 3D point for visualization component.</returns>
        private Point3D[] GetSurfacePoints(Model3DData model3D)
        {
            // normalize for vizualize
            double xMul = 14 / (model3D.Xmax - model3D.Xmin);
            double xPlus = -8 - xMul * model3D.Xmin;
            double yMul = 14 / (model3D.Ymax - model3D.Ymin);
            double yPlus = -8 - yMul * model3D.Ymin;
            double zMul = 4 / (model3D.Zmax - model3D.Zmin);
            double zPlus = 2 - zMul * model3D.Zmin;

            Point3D[] points = new Point3D[surfaceSize * surfaceSize];
            if (points.Length == model3D.PointList.Count)
            {
                for (int idx = 0; idx < model3D.PointList.Count; idx++)
                {
                    double x = model3D.PointList[idx].X;
                    double y = model3D.PointList[idx].Y;
                    double z = model3D.PointList[idx].Z;
                    x *= xMul; x += xPlus;
                    y *= yMul; y += yPlus;
                    z *= zMul; z += zPlus;
                    points[idx] = new Point3D(x, y, z);
                }
            }
            return points;
        }

        /// <summary>
        /// Generates triangle from 3 points.
        /// </summary>
        /// <param name="p0">A Kit3D.Windows.Media.Media3D.Point3D that specifies
        /// 3D point for visualization component.</param>
        /// <param name="p1">A Kit3D.Windows.Media.Media3D.Point3D that specifies
        /// 3D point for visualization component.</param>
        /// <param name="p2">A Kit3D.Windows.Media.Media3D.Point3D that specifies
        /// 3D point for visualization component.</param>
        /// <returns>A Kit3D.Windows.Media.Media3D.Model3DGroup that specifies
        /// trianle of triangle.</returns>
        private Model3DGroup CreateTriangleModel(Point3D p0, Point3D p1, Point3D p2)
        {
            MeshGeometry3D mesh = new MeshGeometry3D();
            mesh.Positions.Add(p0);
            mesh.Positions.Add(p1);
            mesh.Positions.Add(p2);
            mesh.TriangleIndices.Add(0);
            mesh.TriangleIndices.Add(1);
            mesh.TriangleIndices.Add(2);
            mesh.TextureCoordinates.Add(new Point(1, 1));
            mesh.TextureCoordinates.Add(new Point(1, 0));
            mesh.TextureCoordinates.Add(new Point(0, 1));
            Material material = new DiffuseMaterial(new Kit3DBrush(
                new SolidColorBrush(CalculateColor(CalculateNormal(p0, p1, p2)))));
            GeometryModel3D model = new GeometryModel3D(
                mesh, material);
            Model3DGroup group = new Model3DGroup();
            group.Children.Add(model);

            return group;
        }

        /// <summary>
        /// Calculates normal vector from 3 points.
        /// </summary>
        /// <param name="p0">A Kit3D.Windows.Media.Media3D.Point3D that specifies
        /// 3D point for visualization component.</param>
        /// <param name="p1">A Kit3D.Windows.Media.Media3D.Point3D that specifies
        /// 3D point for visualization component.</param>
        /// <param name="p2">A Kit3D.Windows.Media.Media3D.Point3D that specifies
        /// 3D point for visualization component.</param>
        /// <returns>A Kit3D.Windows.Media.Media3D.Vector3D that specifies
        /// normale vector of triangle.</returns>
        private Vector3D CalculateNormal(Point3D p0, Point3D p1, Point3D p2)
        {
            Vector3D v0 = new Vector3D(
                p1.X - p0.X, p1.Y - p0.Y, p1.Z - p0.Z);
            Vector3D v1 = new Vector3D(
                p2.X - p1.X, p2.Y - p1.Y, p2.Z - p1.Z);
            Vector3D normal = Vector3D.CrossProduct(v0, v1);
            double denom = Math.Sqrt(normal.X * normal.X + normal.Y * normal.Y + normal.Z * normal.Z);
            normal.X /= denom;
            normal.Y /= denom;
            normal.Z /= denom;
            return normal;
        }

        /// <summary>
        /// Calculates color of triangle.
        /// </summary>
        /// <param name="vector">A Kit3D.Windows.Media.Media3D.Vector3D that specifies
        /// normale vector of triangle.</param>
        /// <returns>A System.Windows.Media.Color that specifies
        /// ARGB value of color.</returns>
        private Color CalculateColor(Vector3D vector)
        {
            // Lambertian reflectance , Id = |N|*|L|*cos(a)*C*Il
            // N  - normal vector
            // L  - light vector
            // a  - angle between normal and light vector
            // C  - material color
            // Il - intensity of incoming light (here is equal 1)
            double intense = 0;
            double scalar = Vector3D.DotProduct(vector, light);
            if (scalar < 0)
                intense -= scalar;
            Color material = Colors.Green;
            return Color.FromArgb(material.A, (byte)(material.R * intense), (byte)(material.G * intense), (byte)(material.B * intense));
        }

        /// <summary>
        /// Calculates XYZ-coordinates from x- and y- angles.
        /// </summary>
        /// <param name="xAngle">A System.Double that specifies
        /// x-angle.</param>
        /// <param name="yAngle">A System.Double that specifies
        /// y-angle.</param>
        /// <param name="x">A System.Double that specifies
        /// x-coordinate.</param>
        /// <param name="y">A System.Double that specifies
        /// y-coordinate.</param>
        /// <param name="z">A System.Double that specifies
        /// z-coordinate.</param>
        private void Calculate(double xAngle, double yAngle, out double x, out double y, out double z)
        {
            double xRad = Math.PI * xAngle / 180;
            double yRad = Math.PI * yAngle / 180;

            x = 20 * Math.Sin(xRad) * Math.Cos(yRad);
            y = 20 * Math.Sin(xRad) * Math.Sin(yRad);
            z = 20 * Math.Cos(xRad);
        }

        /// <summary>
        /// Sets default position of camera.
        /// </summary>
        private void ClearCamera()
        {
            xAngle = 55;
            yAngle = 45;
            SetCamera();
        }

        /// <summary>
        /// Sets new position of camera.
        /// </summary>
        private void SetCamera()
        {
            double x, y, z;
            Calculate(xAngle, yAngle, out x, out y, out z);
            mainViewport.Camera = new PerspectiveCamera(new Point3D(x, y, z), new Vector3D(-x, -y, -z), new Vector3D(0, 0, 1), 80);
        }

        /// <summary>
        /// Clears visualizated surface.
        /// </summary>
        public void Clear()
        {
            ModelVisual3D m;
            for (int i = mainViewport.Children.Count - 1; i >= 0; i--)
            {
                m = (ModelVisual3D)mainViewport.Children[i];
                //if (m.Content is DirectionalLight == false)
                mainViewport.Children.Remove(m);
            }
        }

        /// <summary>
        /// Moves camera around tha half-sphere.
        /// </summary>
        /// <param name="deltaX">A System.Double that specifies
        /// delta x-angle.</param>
        /// <param name="deltaY">A System.Double that specifies
        /// delta y-angle.</param>
        public void MoveCamera(double deltaX, double deltaY)
        {
            xAngle += deltaX;
            if (xAngle < -85)
                xAngle = -85;
            if (xAngle > 85)
                xAngle = 85;
            yAngle += deltaY;
            if (yAngle < -85)
                yAngle = 85;
            if (yAngle > 85)
                yAngle = 85;
            SetCamera();
        }

        /// <summary>
        /// Shows the sample of surface.
        /// </summary>
        /// <param name="model3D">A WebMech.Web.Model3DData that specifies
        /// data object of 3D model with basic statistic data and list of 3D points.</param>
        public void ShowSample(Model3DData model3D)
        {
            Clear();
            ClearCamera();

            Model3DGroup surface = new Model3DGroup();
            Point3D[] points = GetSurfacePoints(model3D);
            for (int y = 0; y < (surfaceSize * (surfaceSize - 1)); y += surfaceSize)
            {
                for (int x = 0; x < (surfaceSize - 1); x++)
                {
                    surface.Children.Add(
                        CreateTriangleModel(
                                points[x + y + surfaceSize],
                                points[x + y],
                                points[x + y + 1])
                    );
                    surface.Children.Add(
                        CreateTriangleModel(
                                points[x + y + surfaceSize],
                                points[x + y + 1],
                                points[x + y + surfaceSize + 1])
                    );
                }
            }
            ModelVisual3D model = new ModelVisual3D();
            model.Content = surface;
            mainViewport.Children.Add(model);
        }
    }
}
