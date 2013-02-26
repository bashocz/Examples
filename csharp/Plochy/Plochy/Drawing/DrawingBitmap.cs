using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Ink;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Plochy
{
    public class DrawingBitmap : INotifyPropertyChanged
    {
        private readonly double scale = 80;

        private readonly double alpha3D = Math.PI / 4;
        private readonly double scale3D = 0.5;

        private WriteableBitmap bmp;

        private bool drawingAxis;
        private bool drawingGrid;
        private bool drawingPoint;
        private bool drawingSurface;

        private Point bmpCenter = new Point(0, 0);
        private readonly List<double> zoomList = 
            new List<double>(new double[] { 0.2, 0.25, 0.33, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.5, 3, 4 });
        private int zoomIndex = 0;

        private Mesh mesh;
        private readonly Mesh grid;
        private readonly Mesh axis;

        private Point lastPosition = new Point(double.NaN, double.NaN);
        private bool wasMoved = false;
        private bool isMoving = false;
        private bool isMovingSelectedX = false;
        private bool isMovingSelectedY = false;
        private bool isMovingSelectedZ = false;
        private Point3D selected;
        private Rect selectedX = new Rect();
        private Rect selectedY = new Rect();
        private Rect selectedZ = new Rect();

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }

        public DrawingBitmap(DrawingType drawingType, Mesh mesh, Mesh axis, Mesh grid)
        {
            DrawingType = drawingType;

            this.mesh = mesh;
            this.axis = axis;
            this.grid = grid;

            bmp = null;

            Default();
        }

        private Point Point3DToPoint(Point3D p3D)
        {
            Point p2D = new Point(0, 0);
            switch (DrawingType)
            {
                case DrawingType.drawing3D:
                    p2D = new Point(p3D.X - p3D.Y * scale3D * Math.Cos(alpha3D), p3D.Z - p3D.Y * scale3D * Math.Sin(alpha3D));
                    break;
                case DrawingType.drawing2Dxy:
                    p2D = new Point(p3D.X, p3D.Y);
                    break;
                case DrawingType.drawing2Dxz:
                    p2D = new Point(p3D.X, p3D.Y);
                    break;
                case DrawingType.drawing2Dyz:
                    p2D = new Point(p3D.Y, p3D.Z);
                    break;
            }
            p2D = new Point(scale * p2D.X * Zoom + Center.X * Zoom + bmpCenter.X, -scale * p2D.Y * Zoom + Center.Y * Zoom + bmpCenter.Y);
            return p2D;
        }

        // calculate point position for Cohen-Shutherland algorithm
        private int GetCohen(Point p2D, Rect rect)
        {
            int cohen = 0;
            if (p2D.X < rect.Left)
                cohen |= 0x01;
            if (p2D.X >= rect.Right)
                cohen |= 0x02;
            if (p2D.Y < rect.Top)
                cohen |= 0x04;
            if (p2D.Y >= rect.Bottom)
                cohen |= 0x08;
            return cohen;
        }

        private int GetCohenBitmap(Point p2D)
        {
            return GetCohen(p2D, new Rect(0, 0, bmp.PixelWidth, bmp.PixelHeight));
        }

        private void DrawPoint(Point3D p3D, Color color)
        {
            Point p2D = Point3DToPoint(p3D);
            int x1 = (int)Math.Round(p2D.X) - 1;
            int y1 = (int)Math.Round(p2D.Y) - 1;
            int x2 = (int)Math.Round(p2D.X);
            int y2 = (int)Math.Round(p2D.Y);
            int cohenP1 = GetCohenBitmap(new Point(x1, y1));
            int cohenP2 = GetCohenBitmap(new Point(x2, y2));
            if ((cohenP1 == 0) && (cohenP2 == 0))
                bmp.DrawRectangle(x1, y1, x2, y2, color);
        }

        // using Cohen-Shutherland algorithm
        private bool VisibleLine(Point3D p3D1, Point3D p3D2, out int x1, out int y1, out int x2, out int y2)
        {
            Point p2D1 = Point3DToPoint(p3D1);
            Point p2D2 = Point3DToPoint(p3D2);

            x1 = (int)Math.Round(p2D1.X);
            y1 = (int)Math.Round(p2D1.Y);
            x2 = (int)Math.Round(p2D2.X);
            y2 = (int)Math.Round(p2D2.Y);

            int cohenP1 = GetCohenBitmap(new Point(x1, y1));
            int cohenP2 = GetCohenBitmap(new Point(x2, y2));

            if ((cohenP1 == 0) && (cohenP2 == 0))
                return true;
            if ((cohenP1 == cohenP2) && (cohenP1 != 0))
                return false;
            if ((cohenP1 & cohenP2) != 0)
                return false;

            double tan = (p2D2.Y - p2D1.Y) / (p2D2.X - p2D1.X);
            int yForX0 = (int)Math.Round((0 - p2D1.X)*tan + p2D1.Y);
            int xForY0 = (int)Math.Round((0 - p2D1.Y) / tan + p2D1.X);
            int yForXm = (int)Math.Round((bmp.PixelWidth - p2D1.X) * tan + p2D1.Y);
            int xForYm = (int)Math.Round((bmp.PixelHeight - p2D1.Y) / tan + p2D1.X);

            int intersection = 0;

            if ((yForX0 >= 0) && (yForX0 < bmp.PixelHeight))
                intersection |= 0x01;
            if ((yForXm >= 0) && (yForXm < bmp.PixelHeight))
                intersection |= 0x02;
            if ((xForY0 >= 0) && (xForY0 < bmp.PixelWidth))
                intersection |= 0x04;
            if ((xForYm >= 0) && (xForYm < bmp.PixelWidth))
                intersection |= 0x08;

            if ((intersection == 0) || (intersection == 0x01) || (intersection == 0x02) || (intersection == 0x04) || (intersection == 0x08))
                return false;

            if (cohenP1 != 0)
            {
                if (((cohenP1 & 0x01) != 0) && ((intersection & 0x01) != 0))
                {
                    x1 = 0;
                    y1 = yForX0;
                }
                else if (((cohenP1 & 0x02) != 0) && ((intersection & 0x02) != 0))
                {
                    x1 = bmp.PixelWidth - 1;
                    y1 = yForXm;
                }
                else if (((cohenP1 & 0x04) != 0) && ((intersection & 0x04) != 0))
                {
                    x1 = xForY0;
                    y1 = 0;
                }
                else if (((cohenP1 & 0x08) != 0) && ((intersection & 0x08) != 0))
                {
                    x1 = xForYm;
                    y1 = bmp.PixelHeight - 1;
                }
                else
                    return false;
            }
            if (cohenP2 != 0)
            {
                if (((cohenP2 & 0x01) != 0) && ((intersection & 0x01) != 0))
                {
                    x2 = 0;
                    y2 = yForX0;
                }
                else if (((cohenP2 & 0x02) != 0) && ((intersection & 0x02) != 0))
                {
                    x2 = bmp.PixelWidth - 1;
                    y2 = yForXm;
                }
                else if (((cohenP2 & 0x04) != 0) && ((intersection & 0x04) != 0))
                {
                    x2 = xForY0;
                    y2 = 0;
                }
                else if (((cohenP2 & 0x08) != 0) && ((intersection & 0x08) != 0))
                {
                    x2 = xForYm;
                    y2 = bmp.PixelHeight - 1;
                }
                else
                    return false;
            }
            return true;
        }

        private void DrawLine(Point3D p3D1, Point3D p3D2, Color color)
        {
            int x1, y1, x2, y2;
            if (VisibleLine(p3D1, p3D2, out x1, out y1, out x2, out y2))
                bmp.DrawLine(x1, y1, x2, y2, color);
        }

        private void DrawCircle(Point p2D, int radius, Color color)
        {
            int cohenP1 = GetCohenBitmap(new Point(p2D.X - radius, p2D.Y - radius));
            int cohenP2 = GetCohenBitmap(new Point(p2D.X + radius, p2D.Y + radius));
            if ((cohenP1 == 0) && (cohenP2 == 0))
                bmp.DrawEllipseCentered((int)Math.Round(p2D.X), (int)Math.Round(p2D.Y), radius, radius, color);
        }

        private void DrawArrow(Point3D p3D1, Point3D p3D2, Color color)
        {
            DrawLine(p3D1, p3D2, color);

            Point3D norm = new Point3D(p3D2.X - p3D1.X, p3D2.Y - p3D1.Y, p3D2.Z - p3D1.Z);
            double cosA1 = norm.X / (Math.Sqrt(norm.X * norm.X + norm.Y * norm.Y));
            if (double.IsNaN(cosA1))
                cosA1 = 1.0;
            double sinA1 = norm.Y / (Math.Sqrt(norm.X * norm.X + norm.Y * norm.Y));
            if (double.IsNaN(sinA1))
                sinA1 = 0.0;
            double cosA2 = norm.X / (Math.Sqrt(norm.X * norm.X + norm.Z * norm.Z));
            if (double.IsNaN(cosA2))
                cosA2 = 1.0;
            double sinA2 = norm.Z / (Math.Sqrt(norm.X * norm.X + norm.Z * norm.Z));
            if (double.IsNaN(sinA2))
                sinA2 = 0.0;
            double moveX = (0.2 / Zoom) * norm.X / (Math.Sqrt(norm.X * norm.X + norm.Z * norm.Z));
            if (double.IsNaN(moveX))
                moveX = 0.0;
            double moveY = (0.2 / Zoom) * norm.Y / (Math.Sqrt(norm.X * norm.X + norm.Y * norm.Y));
            if (double.IsNaN(moveY))
                moveY = 0.0;
            double moveZ = (0.2 / Zoom) * norm.Z / (Math.Sqrt(norm.X * norm.X + norm.Z * norm.Z));
            if (double.IsNaN(moveZ))
                moveZ = 0.0;
            Point3D move = new Point3D(p3D2.X - moveX, p3D2.Y - moveY, p3D2.Z - moveZ);

            for (double radius = 0; radius < 2 * Math.PI; radius += Math.PI / 50)
            {
                double x = 0;
                double y = (0.05 / Zoom) * Math.Cos(radius);
                double z = (0.05 / Zoom) * Math.Sin(radius);

                // rotation axis Y
                double x1 = x * cosA2 - z * sinA2;
                double y1 = y;
                double z1 = x * sinA2 + z * cosA2;

                // rotation axis Z
                double x2 = x1 * cosA1 - y1 * sinA1;
                double y2 = x1 * sinA1 + y1 * cosA1;
                double z2 = z1;

                // moving
                double x3 = x2 + move.X;
                double y3 = y2 + move.Y;
                double z3 = z2 + move.Z;

                DrawLine(p3D2, new Point3D(x3, y3, z3), color);
            }
        }

        private void DrawArrows(Point3D p3D)
        {
            double startOffset = 0.1 / Zoom;
            double endOffset = 1 / Zoom;
            // x-axis
            if (((DrawingType == DrawingType.drawing3D) ||
                (DrawingType == DrawingType.drawing2Dxy) ||
                (DrawingType == DrawingType.drawing2Dxz)) && (!isMovingSelectedY) && (!isMovingSelectedZ))
            {
                Point3D p3D1 = new Point3D(p3D.X + startOffset, p3D.Y, p3D.Z);
                Point3D p3D2 = new Point3D(p3D.X + endOffset, p3D.Y, p3D.Z);
                if (!isMovingSelectedX)
                    DrawArrow(p3D1, p3D2, mesh.ColorArrowX);
                else
                    DrawArrow(p3D1, p3D2, mesh.ColorArrowSelected);
                Point p2D1 = Point3DToPoint(p3D1);
                Point p2D2 = Point3DToPoint(p3D2);
                selectedX = new Rect(Math.Min(p2D1.X, p2D2.X) - 10, Math.Min(p2D1.Y, p2D2.Y) - 10,
                    Math.Abs(p2D1.X - p2D2.X) + 20, Math.Abs(p2D1.Y - p2D2.Y) + 20);
            }
            // y-axis
            if (((DrawingType == DrawingType.drawing3D) ||
                (DrawingType == DrawingType.drawing2Dxy) ||
                (DrawingType == DrawingType.drawing2Dyz)) && (!isMovingSelectedX) && (!isMovingSelectedZ))
            {
                Point3D p3D1 = new Point3D(p3D.X, p3D.Y + startOffset, p3D.Z);
                Point3D p3D2 = new Point3D(p3D.X, p3D.Y + endOffset, p3D.Z);
                if (!isMovingSelectedY)
                    DrawArrow(p3D1, p3D2, mesh.ColorArrowY);
                else
                    DrawArrow(p3D1, p3D2, mesh.ColorArrowSelected);
                Point p2D1 = Point3DToPoint(p3D1);
                Point p2D2 = Point3DToPoint(p3D2);
                selectedY = new Rect(Math.Min(p2D1.X, p2D2.X) - 10, Math.Min(p2D1.Y, p2D2.Y) - 10,
                    Math.Abs(p2D1.X - p2D2.X) + 20, Math.Abs(p2D1.Y - p2D2.Y) + 20);
            }
            // z-axis
            if (((DrawingType == DrawingType.drawing3D) ||
                (DrawingType == DrawingType.drawing2Dxz) ||
                (DrawingType == DrawingType.drawing2Dyz)) && (!isMovingSelectedX) && (!isMovingSelectedY))
            {
                Point3D p3D1 = new Point3D(p3D.X, p3D.Y, p3D.Z + startOffset);
                Point3D p3D2 = new Point3D(p3D.X, p3D.Y, p3D.Z + endOffset);
                if (!isMovingSelectedZ)
                    DrawArrow(p3D1, p3D2, mesh.ColorArrowZ);
                else
                    DrawArrow(p3D1, p3D2, mesh.ColorArrowSelected);
                Point p2D1 = Point3DToPoint(p3D1);
                Point p2D2 = Point3DToPoint(p3D2);
                selectedZ = new Rect(Math.Min(p2D1.X, p2D2.X) - 10, Math.Min(p2D1.Y, p2D2.Y) - 10,
                    Math.Abs(p2D1.X - p2D2.X) + 20, Math.Abs(p2D1.Y - p2D2.Y) + 20);
            }
        }

        private void DrawEdges(IList<Edge> edgeList)
        {
            foreach (Edge edge in edgeList)
            {
                DrawLine(edge.StartPoint, edge.EndPoint, edge.Color);
            }
        }

        private void DrawGrid()
        {
            DrawEdges(grid.EdgeList);
        }

        private void DrawAxis()
        {
            DrawEdges(axis.EdgeList);
        }

        private void DrawSurface(IList<Edge> edgeList)
        {
            foreach (Edge edge in edgeList)
            {
                if (!(edge.StartPoint is Point3DVisible) && !(edge.EndPoint is Point3DVisible))
                    DrawLine(edge.StartPoint, edge.EndPoint, edge.Color);
            }
        }

        private void DrawPoints(IList<Point3D> pointList, IList<Edge> edgeList)
        {
            foreach (Edge edge in edgeList)
            {
                if ((edge.StartPoint is Point3DVisible) || (edge.EndPoint is Point3DVisible))
                    DrawLine(edge.StartPoint, edge.EndPoint, edge.Color);
            }
            foreach (Point3D p3D in pointList)
            {
                if (p3D is Point3DVisible)
                {
                    DrawPoint(p3D, (p3D as Point3DVisible).Color);
                }
            }
        }

        private void DrawSelected(Point3D p3D)
        {
            Point p2D = Point3DToPoint(p3D);

            DrawPoint(p3D, mesh.ColorPointSelected);

            if ((drawingAxis || drawingGrid) && (DrawingType == DrawingType.drawing3D))
            {
                DrawLine(new Point3D(p3D.X, p3D.Y, 0), p3D, mesh.ColorPointSelectedAxis);
                DrawLine(new Point3D(p3D.X, p3D.Y, 0), new Point3D(0, p3D.Y, 0), mesh.ColorPointSelectedAxis);
                DrawLine(new Point3D(p3D.X, p3D.Y, 0), new Point3D(p3D.X, 0, 0), mesh.ColorPointSelectedAxis);
            }

            DrawCircle(p2D, 10, mesh.ColorPointSelectedAxis);

            DrawArrows(p3D);
        }

        public void Default()
        {
            Center = new Point(0, 0);
            ZoomIndex = zoomList.IndexOf(1.0);

            DrawingAxis = true;
            DrawingGrid = true;
            DrawingPoint = true;
            DrawingSurface = true;
        }

        public void Draw()
        {
            if (bmp == null)
                return;

            bmpCenter = new Point(bmp.PixelWidth / 2.0, bmp.PixelHeight / 2.0);

            bmp.Clear();

            if (drawingGrid)
                DrawGrid();
            if (drawingAxis)
                DrawAxis();

            if (mesh != null)
            {
                if (drawingSurface)
                    DrawSurface(mesh.EdgeList);
                if (drawingPoint)
                {
                    DrawPoints(mesh.PointList, mesh.EdgeList);
                    if (mesh.Selected != null)
                        DrawSelected(mesh.Selected);
                }
            }

            bmp.Invalidate();
        }

        public void MouseMove(Point newPosition)
        {
            // moving with scene
            if (isMoving)
            {
                if (!double.IsNaN(lastPosition.X) && !double.IsNaN(lastPosition.Y))
                {
                    Center = new Point(
                        Center.X + (newPosition.X - lastPosition.X) / Zoom,
                        Center.Y + (newPosition.Y - lastPosition.Y) / Zoom);
                }
                wasMoved = true;
            }
            // moving with point
            if (isMovingSelectedX)
            {
                double x = (newPosition.X - lastPosition.X) / Zoom / scale;
                mesh.ChangeSelected(x, 0, 0);
                wasMoved = true;
            }
            if (isMovingSelectedY)
            {
                double y = 0;
                switch (DrawingType)
                {
                    case DrawingType.drawing2Dxy:
                        y = -1 * (newPosition.Y - lastPosition.Y) / Zoom / scale;
                        break;
                    case DrawingType.drawing2Dyz:
                        y = (newPosition.X - lastPosition.X) / Zoom / scale;
                        break;
                    case DrawingType.drawing3D:
                        double x = newPosition.X - lastPosition.X;
                        double z = newPosition.Y - lastPosition.Y;
                        y = Math.Sqrt(x * x + z * z) / Zoom / scale3D / scale;
                        if (x > 0)
                            y *= -1;
                        break;
                }
                mesh.ChangeSelected(0, y, 0);
                wasMoved = true;
            }
            if (isMovingSelectedZ)
            {
                double z = -1 * (newPosition.Y - lastPosition.Y) / Zoom / scale;
                mesh.ChangeSelected(0, 0, z);
                wasMoved = true;
            }
            lastPosition = newPosition;
        }

        public void MouseDown(Point position)
        {
            // moving with point
            if ((mesh != null) && (mesh.Selected != null))
            {
                if (GetCohen(position, selectedX) == 0)
                    isMovingSelectedX = true;
                else if (GetCohen(position, selectedY) == 0)
                    isMovingSelectedY = true;
                else if (GetCohen(position, selectedZ) == 0)
                    isMovingSelectedZ = true;
            }
            // moving with scene
            if ((!isMovingSelectedX) && (!isMovingSelectedY) && (!isMovingSelectedZ))
                isMoving = true;
            wasMoved = false;

            // changing selected point
            if (mesh != null)
            {
                selected = null;
                foreach (Point3D p3D in mesh.PointList)
                {
                    if (p3D is Point3DVisible)
                    {
                        Point p2D = Point3DToPoint(p3D);
                        if ((position.X > (p2D.X - 10)) && (position.X < (p2D.X + 10)) &&
                            (position.Y > (p2D.Y - 10)) && (position.Y < (p2D.Y + 10)))
                        {
                            if (selected == null)
                                selected = p3D;
                            else
                            {
                                double d1 = Math.Sqrt(Math.Pow(selected.X - position.X, 2) + Math.Pow(selected.Y - position.Y, 2));
                                double d2 = Math.Sqrt(Math.Pow(p2D.X - position.X, 2) + Math.Pow(p2D.Y - position.Y, 2));
                                if (d2 < d1)
                                    selected = p3D;
                            }
                        }
                    }
                }
            }
        }

        public void MouseUp()
        {
            isMoving = false;
            isMovingSelectedX = false;
            isMovingSelectedY = false;
            isMovingSelectedZ = false;
            if (!wasMoved)
            {
                if (mesh != null)
                    mesh.Selected = selected;
            }
            wasMoved = false;
        }

        public WriteableBitmap Bmp
        {
            get { return bmp; }
            set { bmp = value; }
        }

        public Mesh Mesh
        {
            get { return mesh; }
            set { mesh = value; }
        }

        public Point Center { get; set; }
        public IList<string> ZoomList
        {
            get
            {
                List<string> percentList = new List<string>();
                foreach (double zoom in zoomList)
                {
                    double percent = Math.Round(100.0 * (double)zoom, 2);
                    percentList.Add(percent.ToString() + "%");
                }
                return percentList.AsReadOnly();
            }
        }
        public int ZoomIndex
        {
            get { return zoomIndex; }
            set
            {
                if ((value != zoomIndex) && (value >= 0) && (value < zoomList.Count))
                {
                    zoomIndex = value;
                    NotifyPropertyChanged("ZoomIndex");
                }
            }
        }
        public double Zoom
        {
            get { return zoomList[zoomIndex]; }
        }

        public DrawingType DrawingType { get; private set; }

        public bool DrawingAxis
        {
            get { return drawingAxis; }
            set
            {
                if (value != drawingAxis)
                {
                    drawingAxis = value;
                    NotifyPropertyChanged("DrawingAxis");
                }
            }
        }

        public bool DrawingGrid
        {
            get { return drawingGrid; }
            set
            {
                if (value != drawingGrid)
                {
                    drawingGrid = value;
                    NotifyPropertyChanged("DrawingGrid");
                }
            }
        }

        public bool DrawingPoint
        {
            get { return drawingPoint; }
            set
            {
                if (value != drawingPoint)
                {
                    drawingPoint = value;
                    NotifyPropertyChanged("DrawingPoint");
                }
            }
        }

        public bool DrawingSurface
        {
            get { return drawingSurface; }
            set
            {
                if (value != drawingSurface)
                {
                    drawingSurface = value;
                    NotifyPropertyChanged("DrawingSurface");
                }
            }
        }
    }
}
