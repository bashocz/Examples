using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Castle.Facilities.WcfIntegration;
using Castle.Windsor;
using Castle.MicroKernel.Registration;

namespace WcfServiceCastleFacilities
{
    public class ServiceInitializer
    {
        public static void AppInitialize()
        {
            IWindsorContainer container = new WindsorContainer();
            container.Kernel.AddFacility<WcfFacility>();
            container.Kernel.Register(Component.For<ILogger>().ImplementedBy<Logger>());
            container.Kernel.Register(Component.For<IMyServiceCastle>().ImplementedBy<MyServiceCastle>().AsWcfService().Named("MyServiceCastle"));
        }
    }
}