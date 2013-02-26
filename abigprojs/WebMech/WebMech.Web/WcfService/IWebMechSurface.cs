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
    // NOTE: If you change the interface name "IWebMechSurface" here, you must also update the reference to "IWebMechSurface" in Web.config.
    [ServiceContract]
    public interface IWebMechSurface
    {
        [OperationContract()]
        SurfaceData AddSurface(string name);
        [OperationContract()]
        void ModifySurface(SurfaceData surfaceData);
        [OperationContract()]
        void DeleteSurface(SurfaceData surfaceData);
        [OperationContract()]
        SurfaceData GetSurfaceById(int surfaceId);
        [OperationContract()]
        SurfaceData GetSurfaceByName(string name);
        [OperationContract()]
        PageInfoData GetSurfaceListPageInfo(SearchFilterData filterData);
        [OperationContract()]
        List<SurfaceData> GetSurfaceList(SearchFilterData filterData);
    }
}
