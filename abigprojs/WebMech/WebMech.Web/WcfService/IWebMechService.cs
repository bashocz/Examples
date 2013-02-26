using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.IO;
using System.Collections.ObjectModel;

namespace WebMech.Web
{
    // NOTE: If you change the interface name "IWebMechService" here, you must also update the reference to "IWebMechService" in Web.config.
    //[ServiceContract(SessionMode = SessionMode.Required)]
    [ServiceContract]
    public interface IWebMechService :
        IWebMechSurface, IWebMechSample { }
}
