using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public class Item : INotifyPropertyChanged
    {
        private int productId;
        private Product product;
        private Nullable<int> orderId;
        private Order order;
        private int count;

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
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
                    NotifyPropertyChanged("TotalPriceString");
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

        public int Count
        {
            get { return count; }
            set
            {
                if (value != count)
                {
                    count = value;
                    NotifyPropertyChanged("Count");
                    NotifyPropertyChanged("TotalPriceString");
                }
            }
        }

        public string TotalPriceString
        {
            get
            {
                if (product != null)
                    return (count * product.Price).ToString("0.00");
                return "0.00";
            }
        }
    }
}
