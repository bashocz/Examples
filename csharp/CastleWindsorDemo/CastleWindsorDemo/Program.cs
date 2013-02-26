using System;
using Castle.MicroKernel.Registration;
using Castle.Windsor;
using Castle.Facilities.TypedFactory;
using Castle.MicroKernel;
using Castle.MicroKernel.Context;
using Castle.Core;
using System.Collections.Generic;

namespace CastleWindsorDemo
{
    #region config

    public interface IRs232Config
    {
        string PortName { get; }
    }

    public class Rs232Config : IRs232Config
    {
        public string PortName { get; set; }
    }

    #endregion

    #region communication

    public interface IRs232Communication
    {

    }

    public class Rs232Communication : IRs232Communication
    {
        public Rs232Communication(IRs232Config config)
        {
            _config = config;
        }

        private IRs232Config _config;
    }

    #endregion

    #region demount plc

    public interface IDemountPlc
    {

    }

    public class DemountPlc : IDemountPlc
    {
        public DemountPlc(IRs232Communication client)
        {
            _client = client;
        }

        private IRs232Communication _client;
    }

    #endregion

    #region mount plc

    public interface IMountPlc
    {

    }

    public class MountPlc : IMountPlc
    {
        public MountPlc(IRs232Communication client)
        {
            _client = client;
        }

        private IRs232Communication _client;
    }

    #endregion

    public interface IRealPlcFactory
    {
        IRs232Config ResolveRs232Config(string portName);
        IRs232Communication ResolveRs232Communication(IRs232Config config);

        IMountPlc GetMountPlc { get; }
        IDemountPlc DemountPlc { get; }
    }

    #region typed factory

    public interface IDummyComponentFactory
    {
        IDummyComponent GetComponent1();
        IDummyComponent GetComponent2();
        IDummyComponent GetComponent3();

        IDummyComponent GetComponent1Pokus();
        IDummyComponent GetComponent2Pokus();
        IDummyComponent GetComponent3Pokus();

        void Release(IDummyComponent dummyComponent);
    }

    public interface IDummyComponent
    {
        void WriteGuid();
    }

    public class Component2 : IDummyComponent
    {
        public Component2()
        {
            _guid = Guid.NewGuid();
        }

        private Guid _guid;

        public void WriteGuid()
        {
            Console.WriteLine(_guid);
        }
    }

    public class Component2Log : IDummyComponent
    {
        public Component2Log(IDummyComponent component)
        {
            _component = component;
            _guid = Guid.NewGuid();
        }

        IDummyComponent _component;
        private Guid _guid;

        public void WriteGuid()
        {
            Console.WriteLine(_guid);
        }
    }



    #endregion

    class Program
    {
        #region obalovani

        public interface IParent
        {
            void Method();
        }

        public interface IClass1
        {
            void Method1();
        }

        public interface IClass2
        {
            void Method2();
        }

        public class Parent : IParent
        {
            // instance typu transient
            public IClass1 Inst1 { get; set; }
            public IClass1 Inst2 { get; set; }
            public IClass1 Inst3 { get; set; }

            // instance typu singleton
            public IClass2 Inst4 { get; set; }
            public IClass2 Inst5 { get; set; }
            public IClass2 Inst6 { get; set; }

            public void Method()
            {
                Console.WriteLine("Inst1 - transient type");
                Inst1.Method1();

                Console.WriteLine("Inst2 - transient type");
                Inst2.Method1();

                Console.WriteLine("Inst3 - transient type");
                Inst3.Method1();

                Console.WriteLine("Inst4 - singleton type");
                Inst4.Method2();

                Console.WriteLine("Inst5 - singleton type");
                Inst5.Method2();

                Console.WriteLine("Inst6 - singleton type");
                Inst6.Method2();
            }
        }

        public class Class1 : IClass1
        {
            Guid _guid = Guid.NewGuid();

            #region IClass1 members

            public void Method1()
            {
                // zde se vola nejaky vykonny kod
                Console.WriteLine(_guid.ToString());
            }

            #endregion

            #region IParent members

            public void Method()
            {
                throw new System.NotImplementedException();
            }

            #endregion
        }

        public class Class2 : IClass2
        {
            Guid _guid = Guid.NewGuid();

            #region IClass2 members

            public void Method2()
            {
                Console.WriteLine(_guid.ToString());
            }

            #endregion

            #region IParent members

            public void Method()
            {
                throw new System.NotImplementedException();
            }

            #endregion
        }

        public class LogClass1 : IClass1
        {
            public LogClass1(IClass1 obj)
            {
                _obj = obj;
            }

            private IClass1 _obj;

            public void Method1()
            {
                Console.WriteLine("nejake logovani");
                _obj.Method1();
                Console.WriteLine("nejake logovani");
            }


            public void Method()
            {
                throw new NotImplementedException();
            }
        }

        public class LogClass2 : IClass2
        {
            public LogClass2(IClass2 obj)
            {
                _obj = obj;
            }

            private IClass2 _obj;

            public void Method2()
            {
                Console.WriteLine("nejake logovani");
                _obj.Method2();
                Console.WriteLine("nejake logovani");
            }

            public void Method()
            {
                throw new NotImplementedException();
            }
        }

        public class LogClass3 : IClass2
        {
            public LogClass3(IClass2 obj)
            {
                _obj = obj;
            }

            private IClass2 _obj;

            public void Method2()
            {
                Console.WriteLine("jeste nejake logovani");
                _obj.Method2();
                Console.WriteLine("jeste nejake logovani");
            }

            public void Method()
            {
                throw new NotImplementedException();
            }
        }

        //static void Main(string[] args)
        //{
        //    WindsorContainer container = new WindsorContainer();

        //    container.Register(Component.For<IParent>().ImplementedBy<Parent>().LifeStyle.Transient);

        //    container.Register(Component.For<IClass1>().ImplementedBy<LogClass1>().LifeStyle.Transient);
        //    container.Register(Component.For<IClass1>().ImplementedBy<Class1>().LifeStyle.Transient);

        //    container.Register(Component.For<IClass2>().ImplementedBy<LogClass2>().LifeStyle.Transient);
        //    container.Register(Component.For<IClass2>().ImplementedBy<Class2>().LifeStyle.Singleton);

        //    IParent result = container.Resolve<IParent>();

        //    result.Method();

        //    container.Release(result);
        //}

        #endregion

        #region scenar 3x polishline plc

        public interface IOrchestrator
        {
            IPlc Plc1 { get; }
            IPlc Plc2 { get; }
            IPlc Plc3 { get; }
        }

        public class Orchestrator : IOrchestrator
        {
            public IPlc Plc1 { get; set; }
            public IPlc Plc2 { get; set; }
            public IPlc Plc3 { get; set; }
        }

        public interface IPlc
        {
            void ProvedVykonnyKod();
        }

        public class Plc : IPlc
        {
            public Plc(ICom com)
            {
                _guid = Guid.NewGuid();
                _com = com;
            }

            private Guid _guid;
            private ICom _com;

            public void ProvedVykonnyKod()
            {
                Console.WriteLine("provadim vykonny kod");
                //Console.WriteLine(_guid);
            }
        }

        public class LogPlc : IPlc
        {
            public LogPlc(IPlc plc)
            {
                _plc = plc;
            }

            private IPlc _plc;

            public void ProvedVykonnyKod()
            {
                Console.WriteLine("nejake logovani");
                _plc.ProvedVykonnyKod();
                Console.WriteLine("nejake logovani");
            }
        }

        public interface ICom
        {

        }

        public class Com : ICom
        {
            public Com(ICfg cfg)
            {
                _cfg = cfg;
            }

            private ICfg _cfg;
        }

        public interface ICfg
        {

        }

        public class Cfg : ICfg
        {
            public int Value { get; set; }
        }

        private class MySubResolver : ISubDependencyResolver
        {
            private readonly IKernel kernel;
            private bool _loggingIsOn = true;

            public MySubResolver(IKernel kernel)
            {
                this.kernel = kernel;
            }

            public bool CanResolve(CreationContext context, ISubDependencyResolver contextHandlerResolver, ComponentModel model, DependencyModel dependency)
            {
                bool result = false;
                result = ((dependency.TargetType != null)
                    && ((dependency.TargetType.Name == "IPlc")

                           )
                      );

                return result;
            }

            public object Resolve(CreationContext context, ISubDependencyResolver contextHandlerResolver, ComponentModel model, DependencyModel dependency)
            {
                //string postfix = "Default";
                string postfix = "";
                if (context.HasAdditionalArguments && context.AdditionalArguments.Contains("Logging") && (Convert.ToBoolean(context.AdditionalArguments["Logging"]) == true))
                    postfix = "Logging";

                //return kernel.Resolve(dependency.TargetType.Name + postfix, dependency.TargetType);
                return kernel.Resolve(dependency.ReferencedComponentName + postfix , dependency.TargetType);
            }
        }

        //static void Main(string[] args)
        //{
        //    WindsorContainer container = new WindsorContainer();

        //    container.Kernel.Resolver.AddSubResolver(new MySubResolver(container.Kernel));

        //    container.AddFacility<TypedFactoryFacility>();

        //    ICfg test = new Cfg() { Value = 5 };

        //    container.Register(Component.For<IPlc>().ImplementedBy<Plc>().Named("Plc1").DependsOn(Property.ForKey<ICom>().Is("Com1")).LifeStyle.Transient);
        //    container.Register(Component.For<IPlc>().ImplementedBy<LogPlc>().Named("Plc1Logging").DependsOn(Property.ForKey<IPlc>().Is("Plc1")).LifeStyle.Transient);
        //    container.Register(Component.For<ICom>().ImplementedBy<Com>().Named("Com1").DependsOn(Property.ForKey<ICfg>().Is("Cfg1")).LifeStyle.Singleton);
        //    container.Register(Component.For<ICfg>().Instance(test).Named("Cfg1").LifeStyle.Singleton);

        //    ICfg test1 = new Cfg() { Value = 6 };

        //    container.Register(Component.For<IPlc>().ImplementedBy<Plc>().Named("Plc2").DependsOn(Property.ForKey<ICom>().Is("Com2")).LifeStyle.Transient);
        //    container.Register(Component.For<IPlc>().ImplementedBy<LogPlc>().Named("Plc2Logging").DependsOn(Property.ForKey<IPlc>().Is("Plc2")).LifeStyle.Transient);
        //    container.Register(Component.For<ICom>().ImplementedBy<Com>().Named("Com2").DependsOn(Property.ForKey<ICfg>().Is("Cfg2")).LifeStyle.Singleton);
        //    container.Register(Component.For<ICfg>().ImplementedBy<Cfg>().DependsOn(Property.ForKey("Value").Eq(6)).Named("Cfg2").LifeStyle.Singleton);

        //    ICfg test2 = new Cfg() { Value = 7 };

        //    container.Register(Component.For<IPlc>().ImplementedBy<Plc>().Named("Plc3").DependsOn(Property.ForKey<ICom>().Is("Com3")).LifeStyle.Transient);
        //    container.Register(Component.For<IPlc>().ImplementedBy<LogPlc>().Named("Plc3Logging").DependsOn(Property.ForKey<IPlc>().Is("Plc3")).LifeStyle.Transient);
        //    container.Register(Component.For<ICom>().ImplementedBy<Com>().Named("Com3").DependsOn(Property.ForKey<ICfg>().Is("Cfg3")).LifeStyle.Singleton);
        //    container.Register(Component.For<ICfg>().Instance(test2).Named("Cfg3").LifeStyle.Singleton);

        //    container.Register(Component.For<IOrchestrator>().ImplementedBy<Orchestrator>()
        //                        .DependsOn(Property.ForKey("plc1").Is("Plc1"),
        //                                   Property.ForKey("plc2").Is("Plc2"),
        //                                   Property.ForKey("plc3").Is("Plc3"))
        //                        .LifeStyle.Transient
        //                        .Named("default")
        //              );

        //    container.Register(Component.For<IOrchestrator>().ImplementedBy<Orchestrator>()
        //                        .DependsOn(Property.ForKey("Plc1").Is("Plc1Logging"),
        //                                   Property.ForKey("Plc2").Is("Plc2Logging"),
        //                                   Property.ForKey("Plc3").Is("Plc3Logging"))
        //                        .LifeStyle.Transient
        //                        .Named("logging")
        //              );

        //    IOrchestrator result1 = container.Resolve<IOrchestrator>(new Dictionary<string, object>() { { "Logging", true } });

        //    IPlc plc1 = result1.Plc1;
        //    plc1.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    IPlc plc2 = result1.Plc2;
        //    plc2.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    IPlc plc3 = result1.Plc3;
        //    plc3.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    container.Release(result1);

        //    result1 = container.Resolve<IOrchestrator>(new Dictionary<string, object>() { { "Logging", false } });

        //    plc1 = result1.Plc1;
        //    plc1.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    plc2 = result1.Plc2;
        //    plc2.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    plc3 = result1.Plc3;
        //    plc3.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    result1 = container.Resolve<IOrchestrator>(new Dictionary<string, object>() { { "Logging", true } });

        //    plc1 = result1.Plc1;
        //    plc1.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    plc2 = result1.Plc2;
        //    plc2.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    plc3 = result1.Plc3;
        //    plc3.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    result1 = container.Resolve<IOrchestrator>(new Dictionary<string, object>() { { "Logging", false } });

        //    plc1 = result1.Plc1;
        //    plc1.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    plc2 = result1.Plc2;
        //    plc2.ProvedVykonnyKod();
        //    Console.WriteLine();

        //    plc3 = result1.Plc3;
        //    plc3.ProvedVykonnyKod();
        //    Console.WriteLine();
        //}

        #endregion

        static void Main(string[] args)
        {
            WindsorContainer container = new WindsorContainer();

            container.AddFacility<TypedFactoryFacility>();
            container.Register(Component.For<IDummyComponent>().ImplementedBy<Component2>().Named("Component1").LifeStyle.Singleton);
            container.Register(Component.For<IDummyComponent>().ImplementedBy<Component2Log>().Named("Component1Pokus").DependsOn(Property.ForKey<IDummyComponent>().Is("Component1")).LifeStyle.Singleton);
            container.Register(Component.For<IDummyComponent>().ImplementedBy<Component2>().Named("Component2").LifeStyle.Singleton);
            container.Register(Component.For<IDummyComponent>().ImplementedBy<Component2Log>().Named("Component2Pokus").DependsOn(Property.ForKey<IDummyComponent>().Is("Component2")).LifeStyle.Singleton);
            container.Register(Component.For<IDummyComponent>().ImplementedBy<Component2>().Named("Component3").LifeStyle.Singleton);
            container.Register(Component.For<IDummyComponent>().ImplementedBy<Component2Log>().Named("Component3Pokus").DependsOn(Property.ForKey<IDummyComponent>().Is("Component3")).LifeStyle.Singleton);
            container.Register(Component.For<IDummyComponentFactory>().AsFactory().LifeStyle.Transient);

            IDummyComponentFactory factory = container.Resolve<IDummyComponentFactory>();

            IDummyComponent component1 = factory.GetComponent1();
            component1.WriteGuid();

            IDummyComponent component2 = factory.GetComponent2();
            component2.WriteGuid();

            IDummyComponent component3 = factory.GetComponent3();
            component3.WriteGuid();

            IDummyComponent component4 = factory.GetComponent1Pokus();
            component4.WriteGuid();

            IDummyComponent component5 = factory.GetComponent2Pokus();
            component5.WriteGuid();

            IDummyComponent component6 = factory.GetComponent3Pokus();
            component6.WriteGuid();
        }
    }
}