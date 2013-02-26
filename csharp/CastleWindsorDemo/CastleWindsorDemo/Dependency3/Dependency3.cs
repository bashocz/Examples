using System;

namespace CastleWindsorDemo
{
    public class Dependency3 : IDependency3
    {
        public void WriteSomethingOnConsole()
        {
            Console.WriteLine("Dependency3 : IDependency3");
        }
    }
}
