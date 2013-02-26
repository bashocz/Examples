using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;

namespace LoggingObjectPropertiesDemo
{
    public class MyClass : MyInterface
    {
        public int IntValue
        {
            get { return 5; }
        }

        public string StringValue
        {
            get { return "Hello"; }
        }

        public bool BoolValue
        {
            get { return true; }
        }
    }

    public interface MyInterface
    {
        int IntValue { get; }
        string StringValue { get; }
        bool BoolValue { get; }
    }

    class Program
    {
        public static string GetLogFor(object target)
        {
            var properties = from property in target.GetType().GetProperties(BindingFlags.Public | BindingFlags.Instance)
                             select new
                             {
                                 Name = property.Name,
                                 Value = property.GetValue(target, null)
                             };

            StringBuilder builder = new StringBuilder();

            foreach (var property in properties)
                builder.Append(property.Name).Append(" = '" + property.Value + "' ");

            return builder.ToString();
        }

        static void Main(string[] args)
        {
            MyInterface foo = new MyClass();

            IList<MyInterface> list = new List<MyInterface>();
            list.Add(new MyClass());
            list.Add(new MyClass());
            list.Add(new MyClass());
            list.Add(new MyClass());
            list.Add(new MyClass());

            Console.WriteLine(GetLogFor(foo));

            Console.WriteLine(list);

            //Console.WriteLine(GetLogFor(list));
        }
    }
}
