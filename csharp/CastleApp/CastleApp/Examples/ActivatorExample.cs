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
    class ActivatorExample
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

            container.Register(Component.For<ICalculatorFactory>().AsFactory().LifeStyle.Transient);

            container.Register(Component.For<ICalculator>().Named("Calculator")
                .Activator<CalculatorActivator>()
                //.DynamicParameters((k, d) =>
                //    {
                //        var calc = k.Resolve<ICalculator>("AddCalculator");
                //        d["Calculator"] = calc;
                //    })
                .LifeStyle.Transient);

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

    class CalculatorActivator : AbstractComponentActivator, IComponentActivator
    {
        public CalculatorActivator(ComponentModel model, DefaultKernel kernel, ComponentInstanceDelegate onCreation, ComponentInstanceDelegate onDestruction)
            : base(model, kernel, onCreation, onDestruction) { }

        protected override object InternalCreate(Castle.MicroKernel.Context.CreationContext context)
        {
            CalcType type = (CalcType)context.AdditionalArguments["type"];
            switch (type)
            {
                case CalcType.Add:
                    return this.Kernel.Resolve<ICalculator>("AddCalculator");
                case CalcType.Multi:
                    return this.Kernel.Resolve<ICalculator>("MultiCalculator");
            }
            return null;
        }

        protected override void InternalDestroy(object instance) { }
    }

    class CalculatorActivator2 : IComponentActivator
    {
        public CalculatorActivator2(ComponentModel model, DefaultKernel kernel, ComponentInstanceDelegate onCreation, ComponentInstanceDelegate onDestruction) { }

        public object Create(Castle.MicroKernel.Context.CreationContext context, Burden burden)
        {
            return null;
        }

        public void Destroy(object instance)
        {
        }
    }
}
