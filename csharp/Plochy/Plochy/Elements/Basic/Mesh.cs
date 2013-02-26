using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;
using System.ComponentModel;

namespace Plochy
{
    public class Mesh : INotifyPropertyChanged
    {
        private readonly List<Point3D> pointList;
        private readonly List<Edge> edgeList;
        private readonly List<Face> faceList;

        public event PropertyChangedEventHandler PropertyChanged;

        protected void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }

        public Mesh()
        {
            pointList = new List<Point3D>();
            edgeList = new List<Edge>();
            faceList = new List<Face>();
        }

        private void RemovePoint(Point3D point)
        {
            if (pointList.Remove(point))
            {
                List<Edge> deleteEdgeList = new List<Edge>();
                foreach (Edge edge in edgeList)
                {
                    if (edge.StartPoint.Equals(point) || edge.EndPoint.Equals(point))
                    {
                        deleteEdgeList.Add(edge);
                    }
                }
                foreach (Edge edge in deleteEdgeList)
                    RemoveEdge(edge);
            }
        }

        private void DeleteFreePoints(List<Point3D> deletePointList)
        {
            foreach (Edge edge in edgeList)
            {
                if (deletePointList.Remove(edge.StartPoint))
                {
                    if (deletePointList.Count == 0)
                        return;
                }
                if (deletePointList.Remove(edge.EndPoint))
                {
                    if (deletePointList.Count == 0)
                        return;
                }
            }

            foreach (Point3D point in deletePointList)
                RemovePoint(point);
        }

        private void RemoveEdge(Edge edge)
        {
            if (edgeList.Remove(edge))
            {
                List<Face> deleteFaceList = new List<Face>();
                foreach (Face face in faceList)
                {
                    foreach (Edge faceEdge in face.EdgeList)
                    {
                        if (faceEdge.Equals(edge))
                        {
                            deleteFaceList.Add(face);
                            break;
                        }
                    }
                }
                foreach (Face face in deleteFaceList)
                    DeleteFace(face);
            }
        }

        private void DeleteFreeEdges(List<Edge> deleteEdgeList)
        {
            foreach (Face face in faceList)
            {
                foreach (Edge edge in face.EdgeList)
                {
                    if (deleteEdgeList.Remove(edge))
                        if (deleteEdgeList.Count == 0)
                            return;
                }
            }

            foreach (Edge edge in deleteEdgeList)
                RemoveEdge(edge);
        }

        private void RemoveFace(Face face)
        {
            if (faceList.Remove(face))
            {
            }
        }

        public void AddPoint(Point3D point)
        {
            if (!pointList.Contains(point))
                pointList.Add(point);
        }

        public void DeletePoint(int index)
        {
            if ((index >= 0) && (index < pointList.Count))
                DeletePoint(pointList[index]);
        }

        public void DeletePoint(Point3D point)
        {
            RemovePoint(point);
        }

        public void ClearPointList()
        {
            pointList.Clear();
            ClearEdgeList();
            ClearFaceList();
        }

        public void AddEdge(Edge edge)
        {
            if (!edgeList.Contains(edge))
                edgeList.Add(edge);
        }

        public void DeleteEdge(int index)
        {
            if ((index >= 0) && (index < edgeList.Count))
                DeleteEdge(edgeList[index]);
        }

        public void DeleteEdge(Edge edge)
        {
            RemoveEdge(edge);

            List<Point3D> deletePointList = new List<Point3D>();
            deletePointList.Add(edge.StartPoint);
            deletePointList.Add(edge.EndPoint);

            DeleteFreePoints(deletePointList);
        }

        public void ClearEdgeList()
        {
            edgeList.Clear();
            faceList.Clear();
        }

        public void AddFace(Face face)
        {
            if (!faceList.Contains(face))
                faceList.Add(face);
        }

        public void DeleteFace(int index)
        {
            if ((index >= 0) && (index < faceList.Count))
                DeleteFace(faceList[index]);
        }

        public void DeleteFace(Face face)
        {
            RemoveFace(face);

            List<Edge> deleteEdgeList = new List<Edge>(face.EdgeList);

            DeleteFreeEdges(deleteEdgeList);
        }

        public void ClearFaceList()
        {
            faceList.Clear();
        }

        public virtual void ChangeSelected(double x, double y, double z)
        {
            if (Selected != null)
            {
                Selected.X += x;
                Selected.Y += y;
                Selected.Z += z;
            }
        }

        public IList<Point3D> PointList
        {
            get { return pointList.AsReadOnly(); }
        }

        public IList<Edge> EdgeList
        {
            get { return edgeList.AsReadOnly(); }
        }

        public IList<Face> FaceList
        {
            get { return faceList.AsReadOnly(); }
        }

        public Point3D Selected { get; set; }

        public Color ColorAxisX { get { return Color.FromArgb(0xff, 0x80, 0x00, 0x00); } }
        public Color ColorAxisY { get { return Color.FromArgb(0xff, 0x00, 0xbb, 0x00); } }
        public Color ColorAxisZ { get { return Color.FromArgb(0xff, 0x00, 0x00, 0x80); } }
        public Color ColorArrowX { get { return Color.FromArgb(0xff, 0xff, 0x00, 0x00); } }
        public Color ColorArrowY { get { return Color.FromArgb(0xff, 0x00, 0xff, 0x00); } }
        public Color ColorArrowZ { get { return Color.FromArgb(0xff, 0x00, 0x00, 0xff); } }
        public Color ColorArrowSelected { get { return Color.FromArgb(0xff, 0xa9, 0xa9, 0xa9); } }
        public Color ColorGrid { get { return Color.FromArgb(0xff, 0x60, 0x60, 0x60); } }
        public Color ColorGridFine { get { return Color.FromArgb(0xff, 0x70, 0x70, 0x70); } }
        public Color ColorPoint { get { return Color.FromArgb(0xff, 0xff, 0x77, 0xff); } }
        public Color ColorPointSelected { get { return Color.FromArgb(0xff, 0xff, 0xff, 0x00); } }
        public Color ColorPointSelectedAxis { get { return Color.FromArgb(0xff, 0xdd, 0xdd, 0xdd); } }
        public Color ColorSurfaceEdge { get { return Color.FromArgb(0xff, 0x00, 0x00, 0x00); } }
        public Color ColorControlEdgeVertical { get { return Color.FromArgb(0xff, 0x99, 0x99, 0x33); } }
        public Color ColorControlEdgeHorizontal { get { return Color.FromArgb(0xff, 0x88, 0x33, 0x55); } }
    }
}
