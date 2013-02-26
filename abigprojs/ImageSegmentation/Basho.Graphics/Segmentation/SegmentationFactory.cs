using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.Graphics.Segmentation
{
    public class SegmentationFactory
    {
        private static SegmentationFactory _instance;
        public static SegmentationFactory Instance
        {
            get { return _instance ?? (_instance = new SegmentationFactory()); }
        }

        public IFhSegmentation GetFhSegmentation()
        {
            return new FhSegmentation();
        }
    }
}
