using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows;

namespace Plochy
{
    public class Face
    {
        private readonly List<Edge> edgeList = new List<Edge>();

        public Face(IEnumerable<Edge> collection)
            : this(collection, Colors.Transparent) { }

        public Face(IEnumerable<Edge> collection, Color color)
        {
            this.edgeList.AddRange(collection);

            Color = color;
        }

        public IList<Edge> EdgeList
        {
            get { return edgeList.AsReadOnly(); }
        }

        public Color Color { get; set; }
    }
}
