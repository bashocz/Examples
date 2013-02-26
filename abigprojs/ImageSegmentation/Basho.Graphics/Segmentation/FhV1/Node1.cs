using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Segmentation
{
    class Node1
    {
        #region constructors

        public Node1(int x, int y, Segment1 segment)
        {
            X = x;
            Y = y;
            Segment = segment;
        }

        #endregion

        #region public members

        public int X { get; private set; }
        public int Y { get; private set; }

        public Segment1 Segment { get; set; }

        #endregion
    }
}
