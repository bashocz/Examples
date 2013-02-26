using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Castle.MicroKernel.Registration;
using Castle.Windsor;
using Castle.MicroKernel.SubSystems.Configuration;

namespace CastleWindsorDemo
{
    public class MyMainAppInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            //container.Register(Component.For<IMyMainClassInterface>().ImplementedBy<MyMainClass>().LifeStyle.Transient);
        }
    }
}
