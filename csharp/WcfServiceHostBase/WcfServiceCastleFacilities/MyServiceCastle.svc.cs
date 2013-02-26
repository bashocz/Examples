using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfServiceCastleFacilities
{
    public interface ILogger
    {
        void Message(string text);
    }

    public class Logger : ILogger, IDisposable
    {
        public void Message(string text)
        {
        }

        public void Dispose()
        {
            return;
        }
    }

    public class MyServiceCastle : IMyServiceCastle
    {
        private readonly ILogger _logger;

        public MyServiceCastle(ILogger logger)
        {
            _logger = logger;
        }

        public string GetData(int value)
        {
            _logger.Message(value.ToString());
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }
    }
}
