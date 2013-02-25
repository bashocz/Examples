using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public class Customer : INotifyPropertyChanged
    {
        private int id;
        private string name;
        private string street;
        private int number;
        private string city;
        private int psc;
        private string phone;
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

        public string Street
        {
            get { return street; }
            set
            {
                if (value != street)
                {
                    street = value;
                    NotifyPropertyChanged("Street");
                }
            }
        }

        public int Number
        {
            get { return number; }
            set
            {
                if (value != number)
                {
                    number = value;
                    NotifyPropertyChanged("Number");
                }
            }
        }

        public string City
        {
            get { return city; }
            set
            {
                if (value != city)
                {
                    city = value;
                    NotifyPropertyChanged("City");
                }
            }
        }

        public int Psc
        {
            get { return psc; }
            set
            {
                if (value != psc)
                {
                    psc = value;
                    NotifyPropertyChanged("Psc");
                }
            }
        }

        public string Phone
        {
            get { return phone; }
            set
            {
                if (value != phone)
                {
                    phone = value;
                    NotifyPropertyChanged("Phone");
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
