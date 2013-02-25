using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public class Plan : INotifyPropertyChanged
    {
        private int id;
        private int productId;
        private Product product;
        private Nullable<int> orderId;
        private Order order;
        private Nullable<int> productionLineId;
        private ProductionLine productionLine;
        private DateTime dateCreation;
        private Nullable<DateTime> dateStart;
        private Nullable<DateTime> dateEnd;
        private int count;
        private string state;

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

        public int ProductId
        {
            get { return productId; }
            set
            {
                if (value != productId)
                {
                    productId = value;
                    NotifyPropertyChanged("ProductId");
                }
            }
        }

        public Product Product
        {
            get { return product; }
            set
            {
                if (value != product)
                {
                    product = value;
                    NotifyPropertyChanged("Product");
                }
            }
        }

        public Nullable<int> OrderId
        {
            get { return orderId; }
            set
            {
                if (value != orderId)
                {
                    orderId = value;
                    NotifyPropertyChanged("OrderId");
                }
            }
        }

        public Order Order
        {
            get { return order; }
            set
            {
                if (value != order)
                {
                    order = value;
                    NotifyPropertyChanged("Order");
                }
            }
        }

        public Nullable<int> ProductionLineId
        {
            get { return productionLineId; }
            set
            {
                if (value != productionLineId)
                {
                    productionLineId = value;
                    NotifyPropertyChanged("ProductionLineId");
                }
            }
        }

        public ProductionLine ProductionLine
        {
            get { return productionLine; }
            set
            {
                if (value != productionLine)
                {
                    productionLine = value;
                    NotifyPropertyChanged("ProductionLine");
                }
            }
        }

        public DateTime DateCreation
        {
            get { return dateCreation; }
            set
            {
                if (value != dateCreation)
                {
                    dateCreation = value;
                    NotifyPropertyChanged("DateCreation");
                }
            }
        }

        public Nullable<DateTime> DateStart
        {
            get { return dateStart; }
            set
            {
                if (value != dateStart)
                {
                    dateStart = value;
                    NotifyPropertyChanged("DateStart");
                }
            }
        }

        public Nullable<DateTime> DateEnd
        {
            get { return dateEnd; }
            set
            {
                if (value != dateEnd)
                {
                    dateEnd = value;
                    NotifyPropertyChanged("DateEnd");
                }
            }
        }

        public int Count
        {
            get { return count; }
            set
            {
                if (value != count)
                {
                    count = value;
                    NotifyPropertyChanged("Count");
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
                }
            }
        }
    }
}
