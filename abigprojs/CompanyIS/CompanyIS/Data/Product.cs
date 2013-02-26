using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public class Product : INotifyPropertyChanged
    {
        private int id;
        private string name;
        private double price;
        private double timeConsuming;
        private int active;

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

        public double Price
        {
            get { return price; }
            set
            {
                if (value != price)
                {
                    price = value;
                    NotifyPropertyChanged("Price");
                    NotifyPropertyChanged("PriceString");
                }
            }
        }

        public string PriceString
        {
            get { return price.ToString("0.00"); }
        }

        public double TimeConsuming
        {
            get { return timeConsuming; }
            set
            {
                if (value != timeConsuming)
                {
                    timeConsuming = value;
                    NotifyPropertyChanged("TimeConsuming");
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
    }
}
