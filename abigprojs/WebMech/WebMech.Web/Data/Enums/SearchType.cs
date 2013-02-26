using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public enum SearchType
    {
        [EnumMember]
        All = 0,
        [EnumMember]
        LastMonths,
        [EnumMember]
        DateRange
    }
}
