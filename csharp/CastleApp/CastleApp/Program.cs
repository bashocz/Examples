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
    class Program
    {
        static void Main(string[] args)
        {
            var example = new ParamTypedFactoryExample();
            //var example = new ActivatorExample();
            //var example = new SelectorExample();
            example.Run();
        }
    }
}
