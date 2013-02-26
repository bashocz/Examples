using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace ExceptionHandlingDemo
{
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

    public interface IMyObj
    {
        int Value { get; }
    }

    public class MyObj : IMyObj
    {
        public int Value { get; set; }
    }

    [Serializable]
    public class A : Exception
    {
        #region constructors

        protected A(SerializationInfo info, StreamingContext context)
            : base(info, context) { }

        public A()
            : base() { }

        public A(string message)
            : base(message) { }

        public A(string message, Exception innerException)
            : base(message, innerException) { }

        #endregion
    }

    [Serializable]
    public class B : Exception
    {
        #region constructors

        protected B(SerializationInfo info, StreamingContext context)
            : base(info, context) { }

        public B()
            : base() { }

        public B(string message)
            : base(message) { }

        public B(string message, Exception innerException)
            : base(message, innerException) { }

        #endregion
    }

    [Serializable]
    public class C : Exception
    {
        #region constructors

        protected C(SerializationInfo info, StreamingContext context)
            : base(info, context) { }

        public C()
            : base() { }

        public C(string message)
            : base(message) { }

        public C(string message, Exception innerException)
            : base(message, innerException) { }

        #endregion
    }

    [Serializable]
    public class D : Exception
    {
        #region constructors

        protected D(SerializationInfo info, StreamingContext context)
            : base(info, context) { }

        public D()
            : base() { }

        public D(string message)
            : base(message) { }

        public D(string message, Exception innerException)
            : base(message, innerException) { }

        #endregion
    }

    class Program
    {
        private static void Test(Exception ex)
        {
            if (ex.GetType() == typeof(A))
                return;

            if (ex.GetType() == typeof(B))
                return;

            if (ex.GetType() == typeof(C))
                return;

            return;
        }

        static void Main(string[] args)
        {
            try
            {
                int x = 5;
                throw new D();
            }
            catch (D ex)
            {
                try
                {
                    throw new Exception("", ex);
                }
                catch (Exception ex1)
                {
                    Test(ex1.InnerException);
                }
            }
        }
    }
}
