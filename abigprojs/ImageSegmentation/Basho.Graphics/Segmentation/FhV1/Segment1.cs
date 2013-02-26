using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Segmentation
{
    class Segment1
    {
        #region constructors

        public Segment1(int id, int k)
        {
            Id = id;
            _k = k;
            Nodes = new List<Node1>();
        }

        #endregion

        #region private members

        private readonly int _k;

        #endregion

        #region public members

        public int Id { get; private set; }
        public List<Node1> Nodes { get; private set; }

        private double _int;
        private double _threshold;
        public double Int
        {
            get { return _int + _threshold; }
        }

        public void Clear()
        {
            Nodes.Clear();
            _int = 0;
            _threshold = _k;
        }

        public void AddNode(Node1 node)
        {
            Clear();
            Nodes.Add(node);
        }

        public void AddNodes(List<Node1> nodes, int edgeWeight)
        {
            foreach (Node1 node in nodes)
                node.Segment = this;
            Nodes.AddRange(nodes);
            _int = edgeWeight;
            _threshold = _k / Nodes.Count;
        }

        #endregion
    }
}
