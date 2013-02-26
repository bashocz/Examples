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
    public class PointData
    {
        [DataMember]
        public double X { get; set; }
        [DataMember]
        public double Y { get; set; }
        [DataMember]
        public double Z { get; set; }
    }
}
