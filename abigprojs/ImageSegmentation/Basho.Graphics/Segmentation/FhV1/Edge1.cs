using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Segmentation
{
    class Edge1 : IComparable
    {
        #region constructors

        public Edge1(Node1 a, Node1 b, int weight)
        {
            A = a;
            B = b;
            Weight = weight;
        }

        #endregion

        #region public members

        public Node1 A { get; private set; }
        public Node1 B { get; private set; }

        public int Weight { get; private set; }

        #endregion

        #region IComparable memebrs

        public int CompareTo(object obj)
        {
            if (obj == null) return 1;

            Edge1 edge = obj as Edge1;
            if (edge != null)
                return this.Weight.CompareTo(edge.Weight);
            else
                throw new ArgumentException("Object is not a Edge");
        }

        #endregion
    }
}
