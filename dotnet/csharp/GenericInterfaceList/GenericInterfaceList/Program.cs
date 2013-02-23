using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho.GenericInterfaceList
{
    class Program
    {
        interface IMyData
        {
            object Data { get; }
            Type DataType { get; }
        }

        abstract class MyData : IMyData
        {
            protected abstract object GetData();
            protected abstract Type GetDataType();

            public object Data
            {
                get { return GetData(); }
            }

            public Type DataType
            {
                get { return GetDataType(); }
            }
        }

        interface IMyData<T> : IMyData
        {
            new T Data { get; }
        }

        class MyData<T> : MyData, IMyData<T>
        {
            protected override object GetData() { return Data; }
            protected override Type GetDataType() { return typeof(T); }

            T _data;
            public new T Data
            {
                get { return _data; }
                private set { _data = value; }
            }

            public MyData(T data)
            {
                Data = data;
            }
        }

        static void Main(string[] args)
        {
            List<IMyData> list = new List<IMyData>();

            list.Add(new MyData<string>("any string"));
            list.Add(new MyData<int>(0));
            list.Add(new MyData<double>(1.23));

            foreach (IMyData myData in list)
                Console.WriteLine(myData.Data);

            Console.ReadKey();
        }
    }
}
