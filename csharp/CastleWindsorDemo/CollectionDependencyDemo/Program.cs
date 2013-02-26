using System.Collections.Generic;
using Castle.MicroKernel.Registration;
using Castle.MicroKernel.Resolvers.SpecializedResolvers;
using Castle.Windsor;
using System.Collections;

namespace CollectionDependencyDemo
{
    public interface IMyCollection
    {
        int Value { get; }
    }

    public class MyColletion : IMyCollection
    {
        public int Value { get; set; }
    }

    public interface IMyInterface
    {

    }

    public class MyClass : IMyInterface
    {
        public MyClass(IList<IMyCollection> list)
        {
            _list = list;
        }

        private IList<IMyCollection> _list;
    }

    class Program
    {
        static void Main(string[] args)
        {
            IWindsorContainer container = new WindsorContainer();
            //container.Kernel.Resolver.AddSubResolver(new CollectionResolver(container.Kernel));

            container.Register(Component.For<IMyCollection>().ImplementedBy<MyColletion>().DependsOn(Property.ForKey("Value").Eq(5)).Named("a"));
            container.Register(Component.For<IMyCollection>().ImplementedBy<MyColletion>().DependsOn(Property.ForKey("Value").Eq(6)).Named("b"));
            container.Register(Component.For<IMyCollection>().ImplementedBy<MyColletion>().DependsOn(Property.ForKey("Value").Eq(7)).Named("c"));

            

            IList<IMyCollection> list = new List<IMyCollection>() { new MyColletion() {Value = 4}, new MyColletion() {Value = 5} };

            //container.Register(Component.For<IList<IMyCollection>>().ImplementedBy<List<IMyCollection>>().DependsOn(Property.ForKey<IList<IMyCollection>>().Is("a")).LifeStyle.Singleton);

            container.Register(Component.For<MyClass>().ServiceOverrides(new { list = new[] { "a", "b", "c" } }));
            //container.Register(Component.For<IMyInterface>().ImplementedBy<MyClass>().DependsOn(new { list = new[] { "a", "b", "c" } }));
            //container.Register(Component.For<MyClass>().DependsOn(Property.ForKey("list").Is(new[] { "a", "b", "c" })));
            //container.Register(Component.For<IMyInterface>().ImplementedBy<MyClass>().DependsOn(Property.ForKey<IList<IMyCollection>>).Is(new { list = new[] { "a", "b", "c" } })));
            

            //container.Register(Component.For<IMyInterface>().ImplementedBy<MyClass>().DependsOn(Property.ForKey("list").Is("test")));
            //container.Register(Component.For<IMyInterface>().ImplementedBy<MyClass>().DependsOn(Property.ForKey("list").Eq(list)));
            //container.Kernel.Resolver.AddSubResolver(new CollectionResolver(container.Kernel));
            //container.Register(Component.For<IMyInterface>().ImplementedBy<MyClass>());
            MyClass result = container.Resolve<MyClass>();
            //IMyInterface result = container.Resolve<IMyInterface>();
        }
    }
}
