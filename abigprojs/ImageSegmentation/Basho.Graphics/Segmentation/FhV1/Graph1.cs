using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Segmentation
{
    class Graph1
    {
        #region constructors

        public Graph1(Node1[,] nodes, List<Edge1> edges, List<Segment1> segments)
        {
            Nodes = nodes;
            Edges = edges;
            Segments = segments;
        }

        #endregion

        #region public members

        public Node1[,] Nodes { get; private set; }
        public List<Edge1> Edges { get; private set; }
        public List<Segment1> Segments { get; private set; }

        #endregion
    }
}
