using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Castle.Windsor;
using Castle.MicroKernel.Registration;
using System.Diagnostics;
using Castle.MicroKernel.Lifestyle.Scoped;
using Castle.Core;
using Castle.DynamicProxy;
using Castle.MicroKernel;
using Castle.Facilities.TypedFactory;
using Castle.MicroKernel.ComponentActivator;

namespace CastleApp
{
    class SelectorExample
    {
        public void Run()
        {
            CalculatorSelector.IsProxy = true;

            Console.WriteLine("Resolve");
            var srv = Container.Resolve<IService>();
            for (int i = 0; i < 2; i++)
            {
                srv.Calc1.Op(i, 4);
                srv.Calc2.Op(i, 4);
            }

            Container.Release(srv);
            Console.WriteLine("Release...");
            Console.WriteLine();

            CalculatorSelector.IsProxy = false;

            Console.WriteLine("Resolve");
            srv = Container.Resolve<IService>();
            for (int i = 10; i < 12; i++)
            {
                srv.Calc1.Op(i, 4);
                srv.Calc2.Op(i, 4);
            }

            Container.Release(srv);
            Console.WriteLine("Release...");
            Console.WriteLine();

            CalculatorSelector.IsProxy = true;

            Console.WriteLine("Resolve");
            srv = Container.Resolve<IService>();
            for (int i = 20; i < 22; i++)
            {
                srv.Calc1.Op(i, 4);
                srv.Calc2.Op(i, 4);
            }

            Container.Release(srv);
            Console.WriteLine("Release...");
            Console.WriteLine();

            Console.ReadKey();
        }

        static CalculatorSelector _calculatorSelector;
        static CalculatorSelector CalculatorSelector
        {
            get { return _calculatorSelector ?? (_calculatorSelector = new CalculatorSelector()); }
        }

        static IWindsorContainer GetContainer()
        {
            var container = new WindsorContainer();

            container.Kernel.AddHandlerSelector(CalculatorSelector);
            container.Register(Component.For<ICalculator, AddCalculator>().LifeStyle.Singleton);
            container.Register(Component.For<ICalculator, ProxyCalculator>().DependsOn(Property.ForKey<ICalculator>().Is<AddCalculator>()).LifeStyle.Transient);
            // + activator not working
            //container.Register(Component.For<ICalculator, ProxyCalculator>().DependsOn(Property.ForKey<ICalculator>().Is<SumCalculator>()).Activator<CalculatorActivator>().LifeStyle.Transient);
            container.Register(Component.For<IService, Service>().LifeStyle.Transient);

            return container;
        }

        static IWindsorContainer _container;
        static IWindsorContainer Container
        {
            get { return _container ?? (_container = GetContainer()); }
        }
    }

    class CalculatorSelector : IHandlerSelector
    {
        public bool IsProxy { get; set; }

        public bool HasOpinionAbout(string key, Type service)
        {
            return service == typeof(ICalculator);
        }

        public IHandler SelectHandler(string key, Type service, IHandler[] handlers)
        {
            foreach (IHandler handler in handlers)
            {
                if (!IsProxy && (handler.ComponentModel.Implementation == typeof(AddCalculator)))
                    return handler;
                if (IsProxy && (handler.ComponentModel.Implementation == typeof(ProxyCalculator)))
                    return handler;
            }
            return handlers.FirstOrDefault();
        }
    }
}
