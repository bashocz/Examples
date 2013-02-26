using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Segmentation
{
    class FhSegmentation1 : IFhSegmentation
    {
        #region generate graph private members

        private List<Segment1> GetSegments(int count, int k)
        {
            List<Segment1> segments = new List<Segment1>(count);
            for (int id = 0; id < count; id++)
                segments.Add(new Segment1(id, k));
            return segments;
        }

        private Node1[,] GetNode(int width, int height, List<Segment1> segments)
        {
            Node1[,] nodes = new Node1[width, height];
            for (int x = 0; x < width; x++)
                for (int y = 0; y < height; y++)
                {
                    nodes[x, y] = new Node1(x, y, segments[y * width + x]);
                    segments[y * width + x].AddNode(nodes[x, y]);
                }
            return nodes;
        }

        private List<Edge1> BuildEdges(int width, int height, byte[,] pixels, Node1[,] nodes)
        {
            List<Edge1> edges = new List<Edge1>();
            for (int y = 0; y < height; y++)
                for (int x = 0; x < width; x++)
                {
                    byte pixel1 = pixels[x, y];
                    if (x < (width - 1))
                    {
                        if (y > 0)
                            edges.Add(new Edge1(nodes[x, y], nodes[x + 1, y - 1], Math.Abs(pixel1 - pixels[x + 1, y - 1]))); // Up-Right
                        edges.Add(new Edge1(nodes[x, y], nodes[x + 1, y], Math.Abs(pixel1 - pixels[x + 1, y]))); // Right
                        if (y < (height - 1))
                            edges.Add(new Edge1(nodes[x, y], nodes[x + 1, y + 1], Math.Abs(pixel1 - pixels[x + 1, y + 1]))); // Down-Right
                    }
                    if (y < (height - 1))
                        edges.Add(new Edge1(nodes[x, y], nodes[x, y + 1], Math.Abs(pixel1 - pixels[x, y + 1]))); // Down
                }
            return edges;
        }

        private Graph1 GetGraph(int width, int height, byte[,] pixels, int k)
        {
            List<Segment1> segments = GetSegments(width * height, k);
            Node1[,] nodes = GetNode(width, height, segments);
            List<Edge1> edges = BuildEdges(width, height, pixels, nodes);

            return new Graph1(nodes, edges, segments);
        }

        #endregion

        #region algorithm private members

        private double MInt(Segment1 a, Segment1 b)
        {
            return Math.Min(a.Int, b.Int);
        }

        private void MergeSegment(Segment1 a, Segment1 b, int weight)
        {
            a.AddNodes(b.Nodes, weight);
            b.Clear();
        }

        #endregion

        #region IFhSegmentation members

        public int[,] BuildSegments(int width, int height, byte[,] pixels, int k)
        {
            Graph1 graph= GetGraph(width, height, pixels, k);

            graph.Edges.Sort();
            foreach (Edge1 edge in graph.Edges)
            {
                try
                {
                    Segment1 a = edge.A.Segment;
                    Segment1 b = edge.B.Segment;
                    if (a.Id != b.Id)
                    {
                        if (edge.Weight > MInt(a, b))
                            continue;
                        MergeSegment(a, b, edge.Weight);
                    }
                }
                catch (Exception)
                {
                    throw;
                }
            }

            int[,] segments = new int[width, height];
            for (int y = 0; y < height; y++)
                for (int x = 0; x < width; x++)
                    segments[x, y] = graph.Nodes[x, y].Segment.Id;
            return segments;
        }

        #endregion
    }
}
