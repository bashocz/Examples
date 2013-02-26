using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Castle.Windsor;
using Castle.MicroKernel.Registration;
using Castle.MicroKernel;
using Castle.Core;
using System.Collections;
using Castle.MicroKernel.Context;


namespace ConsoleApplication1
{
    interface IClass1 { void Method1(); }
    interface IClass2 { void Method2(); }

    static class Counter
    {
        static private int _number = 0;
        static public int Number { get { return _number++; } }
    }

    class Class1 : IClass1 { private int _number; public Class1() { _number = Counter.Number; } public void Method1() { Console.WriteLine(Convert.ToString(_number)); } }
    class Class2 : IClass2 { private int _number; public Class2() { _number = Counter.Number; } public void Method2() { Console.WriteLine(Convert.ToString(_number)); } }

    class LogClass1 : IClass1 { private IClass1 _obj; public LogClass1(IClass1 obj) { _obj = obj; } public void Method1() { Console.WriteLine("logbeg"); _obj.Method1(); Console.WriteLine("logend"); } }
    class LogClass2 : IClass2 { private IClass2 _obj; public LogClass2(IClass2 obj) { _obj = obj; } public void Method2() { Console.WriteLine("logbeg"); _obj.Method2(); Console.WriteLine("logend"); } }

    interface IParent { void Method(); }
    class Parent : IParent
    {
        public IClass1 Inst1 { get; set; }
        public IClass1 Inst2 { get; set; }
        public IClass1 Inst3 { get; set; }

        public IClass2 Inst4 { get; set; }
        public IClass2 Inst5 { get; set; }
        public IClass2 Inst6 { get; set; }

        public void Method()
        {
            Inst1.Method1();
            Inst2.Method1();
            Inst3.Method1();

            Inst4.Method2();
            Inst4.Method2();
            Inst4.Method2();
        }
    }

    class MP1Resolver : ISubDependencyResolver
    {
        private readonly IKernel kernel;
        private bool _loggingIsOn = true;

        public MP1Resolver(IKernel kernel)
        {
            this.kernel = kernel;
        }

        public object Resolve(CreationContext context, ISubDependencyResolver parentResolver,
                                  ComponentModel model,
                                  DependencyModel dependency)
        {
            string postfix = "Default";
            if (context.HasAdditionalArguments && context.AdditionalArguments.Contains("Logging") && (Convert.ToBoolean(context.AdditionalArguments["Logging"]) == true))
                postfix = "Logging";

            return kernel.Resolve(dependency.TargetType.Name + postfix, dependency.TargetType);
        }

        public bool CanResolve(CreationContext context, ISubDependencyResolver parentResolver,
                                  ComponentModel model,
                                  DependencyModel dependency)
        {
            bool ret = false;
            ret = ((dependency.TargetType != null)
                    && ((dependency.TargetType.Name == "IClass1")
                        || (dependency.TargetType.Name == "IClass2")
                       )
                  );

            return ret;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            WindsorContainer container1 = new WindsorContainer();
            container1.Kernel.Resolver.AddSubResolver(new MP1Resolver(container1.Kernel));

            // default, no logging
            container1.Register(Component.For<IClass1>().ImplementedBy<Class1>().Named("IClass1Default").LifeStyle.Transient);
            container1.Register(Component.For<IClass1>().ImplementedBy<LogClass1>().Named("IClass1Logging").LifeStyle.Transient);

            container1.Register(Component.For<IParent>().ImplementedBy<Parent>().LifeStyle.Transient.Named("Default"));

            container1.Register(Component.For<IClass2>().ImplementedBy<LogClass2>().Named("IClass2Logging").LifeStyle.Singleton);
            container1.Register(Component.For<IClass2>().ImplementedBy<Class2>().Named("IClass2Default").LifeStyle.Singleton);
            container1.Register(Component.For<IParent>().ImplementedBy<Parent>().LifeStyle.Transient.Named("logging"));

            IParent parent = container1.Resolve<IParent>(new Dictionary<string, object>() { { "Logging", true } });
            parent.Method();

            container1.Release(parent);


            parent = container1.Resolve<IParent>(new Dictionary<string, object>() { { "Logging", false } });
            parent.Method();

            container1.Release(parent);
        }
    }
}
