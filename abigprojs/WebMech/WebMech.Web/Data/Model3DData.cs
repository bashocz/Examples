using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;
using System.IO;
using System.Collections.ObjectModel;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public class Model3DData
    {
        [DataMember]
        public List<PointData> PointList { get; set; }
        [DataMember]
        public double Xmin { get; set; }
        [DataMember]
        public double Xmax { get; set; }
        [DataMember]
        public double Ymin { get; set; }
        [DataMember]
        public double Ymax { get; set; }
        [DataMember]
        public double Zmin { get; set; }
        [DataMember]
        public double Zmax { get; set; }
        [DataMember]
        public double Zmean { get; set; }
    }
}
