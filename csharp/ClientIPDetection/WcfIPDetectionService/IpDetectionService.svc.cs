using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.ServiceModel.Channels;

namespace WcfIPDetectionService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    public class IpDetectionService : IIpDetectionService
    {
        public ClientInfo GetClientInfo()
        {
            //OperationContext context = OperationContext.Current;
            //MessageProperties prop = context.IncomingMessageProperties;
            //RemoteEndpointMessageProperty endpoint = prop[RemoteEndpointMessageProperty.Name] as RemoteEndpointMessageProperty;
            //string clIp = endpoint.Address;

            //string cfgIp = "10.249.13.30";

            //return new ClientInfo { IpAddress = clIp, ControlIpAddress = cfgIp, IsController = (clIp == cfgIp) };
            return null;
        }
    }
}
