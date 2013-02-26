using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public class SearchFilterData
    {
        [DataMember]
        public int Start { get; set; }
        [DataMember]
        public int Count { get; set; }
        [DataMember]
        public int Total { get; set; }
        [DataMember]
        public SearchType SearchType { get; set; }
        [DataMember]
        public int LastMonths { get; set; }
        [DataMember]
        public DateTime From { get; set; }
        [DataMember]
        public DateTime To { get; set; }
        [DataMember]
        public SortType SortType { get; set; }
        [DataMember]
        public SortDirection SortDirection { get; set; }
    }
}
