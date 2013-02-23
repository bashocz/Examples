using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public enum Role
    {
        Zakaznik,
        Obchodnik,
        Vyroba
    }

    public class User : INotifyPropertyChanged
    {
        private string name;
        private Role role;
        private int customerId;
        private Customer customer;

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
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

        public Role Role
        {
            get { return role; }
            set
            {
                if (value != role)
                {
                    role = value;
                    NotifyPropertyChanged("Role");
                }
            }
        }

        public int CustomerId
        {
            get { return customerId; }
            set
            {
                if (value != customerId)
                {
                    customerId = value;
                    NotifyPropertyChanged("CustomerId");
                }
            }
        }

        public Customer Customer
        {
            get { return customer; }
            set
            {
                if (value != customer)
                {
                    customer = value;
                    NotifyPropertyChanged("Customer");
                }
            }
        }
    }
}
