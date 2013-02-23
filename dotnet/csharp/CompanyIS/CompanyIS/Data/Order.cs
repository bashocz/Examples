using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public enum OrderState
    {
        New,
        InProduction,
        InStore,
        Shipped
    }

    public class Order : INotifyPropertyChanged
    {
        private int id;
        private int customerId;
        private Customer customer;
        private DateTime dateOrder;
        private Nullable<DateTime> dateShipment;
        private string state;
        private List<Item> itemList = new List<Item>();
        private double totalPrice;

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

        public DateTime DateOrder
        {
            get { return dateOrder; }
            set
            {
                if (value != dateOrder)
                {
                    dateOrder = value;
                    NotifyPropertyChanged("DateOrder");
                }
            }
        }

        public Nullable<DateTime> DateShipment
        {
            get { return dateShipment; }
            set
            {
                if (value != dateShipment)
                {
                    dateShipment = value;
                    NotifyPropertyChanged("DateShipment");
                }
            }
        }

        public string State
        {
            get { return state; }
            set
            {
                if (value != state)
                {
                    state = value;
                    NotifyPropertyChanged("State");
                    NotifyPropertyChanged("OrderState");
                }
            }
        }

        public OrderState OrderState
        {
            get
            {
                if (string.Compare(state, "Nova", true) == 0)
                    return OrderState.New;
                if (string.Compare(state, "Vyrabi se", true) == 0)
                    return OrderState.InProduction;
                if (string.Compare(state, "Skladem", true) == 0)
                    return OrderState.InStore;
                return OrderState.Shipped;
            }
        }

        public double TotalPrice
        {
            get { return totalPrice; }
            set
            {
                if (value != totalPrice)
                {
                    totalPrice = value;
                    NotifyPropertyChanged("TotalPrice");
                    NotifyPropertyChanged("TotalPriceString");
                }
            }
        }

        public string TotalPriceString
        {
            get { return totalPrice.ToString("0.00"); }
        }

        public List<Item> Items
        {
            get { return itemList; }
            set
            {
                if (value != itemList)
                {
                    itemList = value;
                    NotifyPropertyChanged("Items");
                }
            }
        }
    }
}
