using System;

namespace CastleWindsorDemo
{
    public class Dependency3a :IDependency3
    {
        public void WriteSomethingOnConsole()
        {
            Console.WriteLine("Dependency3a : IDependency3");
        }
    }
}
