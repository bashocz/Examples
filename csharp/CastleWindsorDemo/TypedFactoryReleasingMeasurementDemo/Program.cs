using System;
using Castle.Facilities.TypedFactory;
using Castle.MicroKernel.Registration;
using Castle.Windsor;

namespace TypedFactoryReleasingMeasurementDemo
{
    public interface IDummyComponentFactory
    {
        IDummyComponent GetAction();
        void Release(IDummyComponent dummyComponent);
    }

    public interface IDummyComponent
    {

    }

    public class DummyComponent : IDummyComponent
    {
        private int[] xxx = new int[1000];
    }

    class Program
    {
        static void Main(string[] args)
        {
            IWindsorContainer container = new WindsorContainer();
            container.AddFacility<TypedFactoryFacility>();

            container.Register(Component.For<IDummyComponent>().ImplementedBy<DummyComponent>().Named("Action").LifeStyle.Transient);
            container.Register(Component.For<IDummyComponentFactory>().AsFactory().LifeStyle.Transient);

            IDummyComponentFactory factory = container.Resolve<IDummyComponentFactory>();

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine("{0:N0} bytes used at the start", GC.GetTotalMemory(true));

                IDummyComponent[] array = new IDummyComponent[10];
                for (int j = 0; j < array.Length; j++)
                    array[j] = factory.GetAction();

                Console.WriteLine("{0:N0} bytes used at the mezivysledek", GC.GetTotalMemory(true));

                for (int j = 0; j < array.Length; j++)
                {
                    factory.Release(array[j]);
                    array[j] = null;
                }

                Console.WriteLine("{0:N0} bytes used at the end", GC.GetTotalMemory(true));
            }
        }
    }
}
