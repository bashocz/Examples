using System;
using Castle.MicroKernel.Registration;
using Castle.Windsor;
using System.Reflection;
using System.Linq;
using System.Linq.Expressions;
using System.Collections.Generic;
using System.Collections;
using Castle.MicroKernel.Resolvers.SpecializedResolvers;

namespace PropertyDependencyDemo
{
    class Program
    {
        #region test1

        public enum Test
        {
            One,
            Two,
            Three
        }

        public interface IClass
        {
            int Property1 { get; set; }
            string Property2 { get; set; }
            bool Property3 { get; set; }
            void SayHello5555(bool text);
        }

        public abstract class BaseClass
        {
            public BaseClass(Test qwer)
            {
                _test = qwer;
            }
            protected Test _test;
        }

        public class Class : BaseClass, IClass
        {
            public Class(Test abcdef) :
                base(abcdef)
            {

            }

            public int Property1 { get; set; }
            public string Property2 { get; set; }
            public bool Property3 { get; set; }

            public void SayHello5555(bool ahoj)
            {
                Console.WriteLine("start " + MethodBase.GetCurrentMethod().Name + " ( " + MemberInfoGetting.GetMemberName(() => ahoj));
                Console.WriteLine(_test.ToString());
                Console.WriteLine("end " + MethodBase.GetCurrentMethod().Name);
            }
        }

        #endregion

        public static class MemberInfoGetting
        {
            public static string GetMemberName<T>(Expression<Func<T>> memberExpression)
            {
                MemberExpression expressionBody = (MemberExpression)memberExpression.Body;
                return expressionBody.Member.Name;
            }
        }

        static void Main(string[] args)
        {
            IClass myclass = new Class(Test.One) { };
            myclass.Property1 = 5;
            myclass.Property2 = "MyValue";
            myclass.Property3 = true;
            myclass.SayHello5555(true);
        }
    }
}
