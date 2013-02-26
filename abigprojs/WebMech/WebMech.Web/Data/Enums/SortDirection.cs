using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public enum SortDirection
    {
        [EnumMember]
        Ascending = 0,
        [EnumMember]
        Descending
    }
}
