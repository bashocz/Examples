using System;

namespace CastleWindsorDemo
{
    public class Dependency4 : IDependency4
    {
        public Dependency4(IDependency5 test)
        {
            _test = test;
        }

        private IDependency5 _test;

        public void PostSomethingOnConsole()
        {
            if (string.IsNullOrEmpty(_test.Test))
                Console.WriteLine("_test is null");
            Console.WriteLine(_test.Test);
        }
    }
}
