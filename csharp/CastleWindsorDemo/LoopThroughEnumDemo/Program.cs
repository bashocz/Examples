using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LoopThroughEnumDemo
{
    public enum Test
    {
        All,
        One,
        Two,
        Three,
    }

    class Program
    {
        static void Main(string[] args)
        {
            var list = (from l in Enum.GetValues(typeof(Test)).Cast<Test>()
                        where l != Test.All
                        select l).ToList();

            foreach (Test test in list)
            {
                Test qwer = test;
                Console.WriteLine(test);
            }
        }
    }
}
