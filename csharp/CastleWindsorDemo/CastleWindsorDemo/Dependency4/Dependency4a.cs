using System;

namespace CastleWindsorDemo
{
    public class Dependency4a : IDependency4
    {
        public void PostSomethingOnConsole()
        {
            Console.WriteLine("Dependency4a : IDependency4");
        }
    }
}
