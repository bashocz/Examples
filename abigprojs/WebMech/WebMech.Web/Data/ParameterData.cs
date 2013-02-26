using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public class ParameterData
    {
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public double Value { get; set; }
    }
}
