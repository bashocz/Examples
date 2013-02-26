using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Castle.Windsor;
using Castle.Facilities.TypedFactory;
using Castle.MicroKernel.Registration;
using System.Runtime.Serialization;

namespace TypedFactoryMethodParametersDemo
{
    #region database

    public interface IDatabase
    {

    }

    public class Database : IDatabase
    {

    }

    #endregion

    #region wrapper

    public interface IPolishLinePlcWrapper
    {
        int PolishLineNumber { get; }
    }

    public class PolishLinePlcWrapper : IPolishLinePlcWrapper
    {
        public int PolishLineNumber { get; set; }
    }

    #endregion

    #region TaskActionFactory

    public interface ITaskActionFactory
    {
        ITaskAction GetPolishLineStart(IPolishLinePlcWrapper plc, IDatabase db);

        void Release(ITaskAction action);
    }

    #endregion

    #region PolishLineStart action

    public interface ITaskAction
    {
    }

    public class PolishLineStartAction : ITaskAction
    {
        public PolishLineStartAction(IPolishLinePlcWrapper plc, IDatabase db)
        {
            _plc = plc;
            _db = db;
        }

        private IPolishLinePlcWrapper _plc;
        private IDatabase _db;
    }

    public class PolishLineStartActionLog : ITaskAction
    {
        public PolishLineStartActionLog(ITaskAction obj)
        {
            _obj = obj;
        }

        private ITaskAction _obj;
    }

    #endregion

    public class PolishLineThreadTask : IPolishLineThreadTask
    {
        public PolishLineThreadTask(IPolishLinePlcWrapper plc, IDatabase db, ITaskActionFactory factory)
        {
            _plc = plc;
            _db = db;
            _factory = factory;
        }

        private IPolishLinePlcWrapper _plc;
        private ITaskActionFactory _factory;
        private IDatabase _db;

        public ITaskAction GetAction()
        {
            return _factory.GetPolishLineStart(_plc, _db);
        }
    }

    public interface IPolishLineThreadTask
    {
        ITaskAction GetAction();
    }

    public interface IMyObj
    {
        int Value { get; }
    }

    public class MyObj : IMyObj
    {
        public int Value { get; set; }
    }

    public interface ITest
    {

    }

    public class Test : ITest
    {
        public Test(IMyObj obj)
        {
            if (obj == null)
                throw new ArgumentNullException("obj");

            _obj = obj;
        }

        public void Write()
        {
            //Console.WriteLine();
        }

        private readonly IMyObj _obj;
    }
    class Program
    {
        //static void Main(string[] args)
        //{
        //    IWindsorContainer container = new WindsorContainer();

        //    container.AddFacility<TypedFactoryFacility>();

        //    container.Register(Component.For<IPolishLineThreadTask>().ImplementedBy<PolishLineThreadTask>().LifeStyle.Transient);
        //    container.Register(Component.For<IPolishLinePlcWrapper>().ImplementedBy<PolishLinePlcWrapper>().LifeStyle.Transient);
        //    container.Register(Component.For<IDatabase>().ImplementedBy<Database>().LifeStyle.Transient);
        //    container.Register(Component.For<ITaskAction>().ImplementedBy<PolishLineStartAction>().Named("PolishLineStartExecutive").LifeStyle.Transient);
        //    container.Register(Component.For<ITaskAction>().ImplementedBy<PolishLineStartActionLog>().DependsOn(Property.ForKey("obj").Is("PolishLineStartExecutive")).Named("PolishLineStart").LifeStyle.Transient);

        //    container.Register(Component.For<ITaskActionFactory>().AsFactory().LifeStyle.Transient);

        //    ITaskActionFactory facotry = container.Resolve<ITaskActionFactory>();

        //    IDatabase db = new Database();
        //    IPolishLinePlcWrapper plc = new PolishLinePlcWrapper() { PolishLineNumber = 2 };
        //    IPolishLineThreadTask threadTask = new PolishLineThreadTask(plc, db, facotry);

        //    ITaskAction action = threadTask.GetAction();
        //}

        public enum PromisErrorCode
        {
            Ok = 0,
            Offline,
            AuthenticationFailed,
            LotTrackInFailed,
            LotTrackOutFailed,
            ParameterNotDefined
        }

        static void Main(string[] args)
        {
            //IWindsorContainer container = new WindsorContainer();

            //container.Register(Component.For<IMyObj>().ImplementedBy<MyObj>().DependsOn(Property.ForKey("Value").Eq(5)).LifeStyle.Singleton);
            //container.Register(Component.For<ITest>().ImplementedBy<Test>().LifeStyle.Singleton);

            //ITest facotry = container.Resolve<ITest>();

            //Console.WriteLine(new PromisErrorCode());

            //PromisErrorCode p = PromisErrorCode.LotTrackInFailed;

            //Console.WriteLine(p.ToString());
        }
    }
}
