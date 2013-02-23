using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfIPDetectionService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IIpDetectionService
    {
        [OperationContract]
        ClientInfo GetClientInfo();
    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class ClientInfo
    {
        [DataMember]
        public string IpAddress { get; set; }

        [DataMember]
        public string ControlIpAddress { get; set; }

        [DataMember]
        public bool IsController { get; set; }
    }
}
