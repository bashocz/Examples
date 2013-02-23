using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public enum Status
    {
        Working,
        NoWorking,
        NoPlan,
    }

    public class ProductionLine : INotifyPropertyChanged
    {
        private int id;
        private string name;
        private int capacity;
        private double efficiency;
        private int active;
        private Status status;
        private Plan plan;

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }

        public int Id
        {
            get { return id; }
            set
            {
                if (value != id)
                {
                    id = value;
                    NotifyPropertyChanged("Id");
                }
            }
        }

        public string Name
        {
            get { return name; }
            set
            {
                if (value != name)
                {
                    name = value;
                    NotifyPropertyChanged("Name");
                }
            }
        }

        public int Capacity
        {
            get { return capacity; }
            set
            {
                if (value != capacity)
                {
                    capacity = value;
                    NotifyPropertyChanged("Capacity");
                }
            }
        }

        public double Efficiency
        {
            get { return efficiency; }
            set
            {
                if (value != efficiency)
                {
                    efficiency = value;
                    NotifyPropertyChanged("Efficiency");
                }
            }
        }

        public int Active
        {
            get { return active; }
            set
            {
                if (value != active)
                {
                    active = value;
                    NotifyPropertyChanged("Active");
                    NotifyPropertyChanged("IsActive");
                }
            }
        }

        public bool IsActive
        {
            get { return active == 1; }
            set
            {
                if (value)
                    Active = 1;
                else
                    Active = 0;
            }
        }

        public Status Status
        {
            get { return status; }
            set
            {
                if (value != status)
                {
                    status = value;
                    NotifyPropertyChanged("Status");
                }
            }
        }

        public Plan Plan
        {
            get { return plan; }
            set
            {
                if (value != plan)
                {
                    plan = value;
                    NotifyPropertyChanged("Plan");
                }
            }
        }
    }
}
