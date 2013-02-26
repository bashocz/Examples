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
using System.Reflection;

namespace CastleApp
{
    class ParamTypedFactoryExample
    {
        public void Run()
        {
            var fact = Container.Resolve<ICalculatorFactory>();

            var calc = fact.GetCalculator(CalcType.Add);

            calc.Op(3, 4);

            calc = fact.GetCalculator(CalcType.Multi);

            calc.Op(3, 4);

            Console.ReadKey();
        }

        static IWindsorContainer GetContainer()
        {
            var container = new WindsorContainer();

            container.AddFacility<TypedFactoryFacility>();

            container.Register(Component.For<ICalculatorFactory>().AsFactory(c => c.SelectedWith(new CalculatorTypedFactoryComponentSelector())).LifeStyle.Transient);

            container.Register(Component.For<ICalculator, AddCalculator>().Named("AddCalculator").LifeStyle.Transient);
            container.Register(Component.For<ICalculator, MultiCalculator>().Named("MultiCalculator").LifeStyle.Transient);

            return container;
        }

        static IWindsorContainer _container;
        static IWindsorContainer Container
        {
            get { return _container ?? (_container = GetContainer()); }
        }
    }

    public class CalculatorTypedFactoryComponentSelector : DefaultTypedFactoryComponentSelector
    {
        protected override string GetComponentName(MethodInfo method, object[] arguments)
        {
            if (method.Name == "GetCalculator" && arguments.Length == 1 && arguments[0] is CalcType)
            {
                var type = (CalcType)arguments[0];
                switch (type)
                {
                    case CalcType.Add:
                        return "AddCalculator";
                    case CalcType.Multi:
                        return "MultiCalculator";
                }
            }
            return "AddCalculator";
        }
    }
}
