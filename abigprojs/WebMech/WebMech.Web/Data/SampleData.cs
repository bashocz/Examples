using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WebMech.Web
{
    [DataContract(Namespace = "http:\\WebMech.Web")]
    public class SampleData
    {
        [DataMember]
        public int Id { get; set; }
        [DataMember]
        public int SurfaceId { get; set; }
        [DataMember]
        public DateTime SampleDate { get; set; }
        [DataMember]
        public DateTime UploadDate { get; set; }
        [DataMember]
        public DateTime ModificationDate { get; set; }
        [DataMember]
        public string FileName { get; set; }
        [DataMember]
        public List<ParameterData> ParameterList { get; set; }
    }
}
