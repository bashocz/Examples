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
    // NOTE: If you change the interface name "IWebMechSample" here, you must also update the reference to "IWebMechSample" in Web.config.
    [ServiceContract]
    public interface IWebMechSample
    {
        [OperationContract()]
        SampleData UploadSample(SurfaceData surfaceData, string imageName, byte[] imageArray, string pointsName, byte[] pointsArray);
        [OperationContract()]
        void ModifySample(SampleData sampleData, string imageName, byte[] imageArray, string pointsName, byte[] pointsArray);
        [OperationContract()]
        void DeleteSample(SampleData sampleData);
        [OperationContract()]
        PageInfoData GetSampleListPageInfo(SearchFilterData filterData, SurfaceData surfaceData);
        [OperationContract()]
        List<SampleData> GetSampleList(SearchFilterData filterData, SurfaceData surfaceData);
        [OperationContract()]
        Model3DData GetSample(SampleData sampleData);
    }
}
