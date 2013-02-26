using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public class PageInfoData
    {
        [DataMember]
        public int Start { get; set; }
        [DataMember]
        public int End { get; set; }
        [DataMember]
        public int Total { get; set; }
        [DataMember]
        public bool IsNext { get; set; }
        [DataMember]
        public bool IsPrevious { get; set; }
    }
}
