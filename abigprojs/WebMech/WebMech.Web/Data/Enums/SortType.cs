using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public enum SortType
    {
        [EnumMember]
        Name = 0,
        [EnumMember]
        Date,
        [EnumMember]
        NumberOfSamples
    }
}
