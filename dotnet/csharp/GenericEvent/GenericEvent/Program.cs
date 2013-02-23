using System;
using System.Collections.Generic;
using System.Text;

namespace Basho.GenericEvent
{
    abstract class BaseConfigData<T> where T : class
    {
        private bool isChanged;
        private bool isFired;

        public BaseConfigData()
        {
            isChanged = false;
            isFired = true;
        }

        public delegate void ConfigChanged(T data);
        public event ConfigChanged OnChanged;

        private void FireEvent()
        {
            isChanged = false;
            ConfigChanged changed = OnChanged;
            if (changed != null)
            {
                changed(this as T);
            }
        }

        protected void Changed()
        {
            isChanged = true;
            if (isFired)
                FireEvent();
        }

        public void BeginUpdate()
        {
            isFired = false;
        }

        public void EndUpdate()
        {
            if (isChanged)
                FireEvent();
            isFired = true;
        }

        public bool IsChanged
        {
            get { return isChanged; }
        }
    }

    class Config1 : BaseConfigData<Config1>
    {
        private bool goingHome = false;

        public bool GoingHome
        {
            get { return goingHome; }
            set
            {
                goingHome = value;
                Changed();
            }
        }
    }

    class Config2 : BaseConfigData<Config2>
    {
        private DateTime starting = new DateTime(2009, 2, 1, 12, 0, 0);

        public DateTime Starting
        {
            get { return starting; }
            set
            {
                starting = value;
                Changed();
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Config1 config1 = new Config1();
            config1.OnChanged += new BaseConfigData<Config1>.ConfigChanged(Config1Changed);
            Console.WriteLine("Leaving: " + config1.GoingHome.ToString());
            config1.GoingHome = true;
            Config2 config2 = new Config2();
            config2.OnChanged += new BaseConfigData<Config2>.ConfigChanged(Config2Changed);
            Console.WriteLine("Date: " + config2.Starting.ToString());
            config2.Starting = DateTime.Now;
            Console.ReadKey();
        }

        static void Config1Changed(Config1 config)
        {
            Console.WriteLine("Leaving changed: " + config.GoingHome.ToString());
        }

        static void Config2Changed(Config2 config)
        {
            Console.WriteLine("Date changed: " + config.Starting.ToString());
        }
    }
}
