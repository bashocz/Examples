using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;

namespace CastleWindsorDemo
{
    class MyInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register
            (

            Component.For<IDependency1>().ImplementedBy<Dependency1>().LifeStyle.Transient,
            Component.For<IDependency2>().ImplementedBy<Dependency2>().LifeStyle.Transient,
            Component.For<IDependency3>().ImplementedBy<Dependency3>().LifeStyle.Transient,
            Component.For<IDependency4>().ImplementedBy<Dependency4>().DependsOn(Property.ForKey("test").Eq("hello")).LifeStyle.Transient,
            Component.For<IMain>().ImplementedBy<Main>().LifeStyle.Transient
            
            );
        }
    }
}
