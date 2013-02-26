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
    interface IService
    {
        ICalculator Calc1 { get; }
        ICalculator Calc2 { get; }
    }

    class Service : IService
    {
        public Service(ICalculator calc1, ICalculator calc2)
        {
            Calc1 = calc1;
            Calc2 = calc2;
        }

        public ICalculator Calc1 { get; private set; }
        public ICalculator Calc2 { get; private set; }
    }

    public enum CalcType
    {
        Add,
        Multi
    }

    public interface ICalculatorFactory
    {
        ICalculator GetCalculator(CalcType type);
        void Release(ICalculator instance);
    }

    public interface ICalculator
    {
        int Op(int x, int y);
    }

    class AddCalculator : ICalculator
    {
        Guid _guid = Guid.NewGuid();

        public int Op(int x, int y)
        {
            Console.WriteLine(string.Format("Calculator.Add(x={0}, y={1}) - GUID {2}", x, y, _guid));
            var add = x + y;
            Console.WriteLine(string.Format("Calculator.Add={0}", add));
            return add;
        }
    }

    class MultiCalculator : ICalculator
    {
        Guid _guid = Guid.NewGuid();

        public int Op(int x, int y)
        {
            Console.WriteLine(string.Format("Calculator.Multi(x={0}, y={1}) - GUID {2}", x, y, _guid));
            var multi = x * y;
            Console.WriteLine(string.Format("Calculator.Multi={0}", multi));
            return multi;
        }
    }

    class ProxyCalculator : ICalculator
    {
        Guid _guid = Guid.NewGuid();

        private ICalculator _instance;
        public ProxyCalculator(ICalculator instance)
        {
            _instance = instance;
        }

        public int Op(int x, int y)
        {
            Console.WriteLine(string.Format("ProxyCalculator.Op(x={0}, y={1}) - GUID {2}", x, y, _guid));
            var res = _instance.Op(x, y);
            Console.WriteLine(string.Format("ProxyCalculator.Op={0}", res));
            return res;
        }
    }
}
