using System;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Description;
using System.ServiceModel.Channels;
using System.ServiceModel.Dispatcher;
using Castle.Facilities.WcfIntegration;
using Castle.MicroKernel;
using System.Collections.Generic;

namespace WcfServiceCastleFacilities
{
    public class MyServiceCastleHostFactory : DefaultServiceHostFactory
    {
        public MyServiceCastleHostFactory() { }

        public MyServiceCastleHostFactory(IKernel kernel)
            : base(kernel) { }

        public override ServiceHostBase CreateServiceHost(string constructorString, Uri[] baseAddresses)
        {
            ServiceHostBase host = base.CreateServiceHost(constructorString, baseAddresses);
            RegisterEventHandlers(host);
            return host;
        }

        protected override ServiceHost CreateServiceHost(Type serviceType, Uri[] baseAddresses)
        {
            ServiceHost host = base.CreateServiceHost(serviceType, baseAddresses);
            RegisterEventHandlers(host);
            return host;
        }

        private void RegisterEventHandlers(ServiceHostBase host)
        {
            host.Opened += new EventHandler(host_Opened);
            host.Closed += new EventHandler(host_Closed);
        }

        void host_Opened(object sender, EventArgs e)
        {
            // doesn't work -> how to get default windsor container
            //ILogger log = ServiceInitializer.Container.Resolve<ILogger>();
        }

        void host_Closed(object sender, EventArgs e)
        {
            // doesn't work -> how to get default windsor container
            //ILogger log = ServiceInitializer.Container.Resolve<ILogger>();
        }
    }
}
