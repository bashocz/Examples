using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Threading;

namespace Basho
{
    /// <summary>
    /// Interaction logic for CustomerControl.xaml
    /// </summary>
    public partial class CustomerControl : UserControl
    {
        private IDataConnection data;

        private Customer customer;

        private List<Order> orderList;

        private List<Product> productList;

        private Order newOrder;

        private List<Item> newOrderItemList;

        private RecordInfo orderRecords = new RecordInfo { Start = 1, Count = 10 };

        public CustomerControl()
        {
            InitializeComponent();

            IsVisibleChanged += new DependencyPropertyChangedEventHandler(CustomerControl_IsVisibleChanged);

            btnUpdate.Click += new RoutedEventHandler(btnUpdate_Click);

            lbPreviewOrders.SelectionChanged += new SelectionChangedEventHandler(lbPreviewOrders_SelectionChanged);
            btnNewOrder.Click += new RoutedEventHandler(btnNewOrder_Click);
            btnAccept.Click += new RoutedEventHandler(btnAccept_Click);
            btnCancel.Click += new RoutedEventHandler(btnCancel1_Click);

            pnlOrderRecords.DataContext = orderRecords;
            ctrlEditCustomer.CanActive(false);
        }

        private void CustomerControl_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                tabs.SelectedIndex = 0;
                GetOrderList();
                GetProductList();
                newOrder = null;
                lbNewOrderItems.ItemsSource = null;
                EnableNewOrderButtons();
            }
        }

        private void lbPreviewOrders_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            lbPreviewOrderItems.ItemsSource = null;

            if (lbPreviewOrders.SelectedItem != null)
            {
                List<Item> itemList = data.GetItems(lbPreviewOrders.SelectedItem as Order);

                lbPreviewOrderItems.ItemsSource = itemList;
            }
        }

        private void btnUpdate_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            GetOrderList();
        }

        private void tbOrderCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                orderRecords.Start = 1;
                GetOrderList();
                e.Handled = true;
            }
        }

        private void btnOrderPrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            orderRecords.Start -= orderRecords.Count;
            GetOrderList();
        }

        private void btnOrderNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            orderRecords.Start += orderRecords.Count;
            GetOrderList();
        }

        private void btnNewOrder_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                newOrder = data.NewOrder(customer);

                newOrderItemList = data.GetItems(newOrder);
                lbNewOrderItems.ItemsSource = newOrderItemList;

                bool found = false;
                foreach (Order order in orderList)
                    if (order.Id == newOrder.Id)
                        found = true;
                if (!found)
                {
                    orderList.Add(newOrder);
                    lbPreviewOrders.SelectedIndex = -1;
                    lbPreviewOrders.ItemsSource = null;
                    lbPreviewOrders.ItemsSource = orderList;
                }

                EnableNewOrderButtons();
            }
            catch { }
        }

        private void btnAccept_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                Order acceptedOrder = data.AcceptOrder(newOrder);

                foreach (Order order in orderList)
                    if (order.Id == newOrder.Id)
                    {
                        order.State = acceptedOrder.State;
                    }

                newOrder = null;
                newOrderItemList = null;
                lbNewOrderItems.ItemsSource = null;

                lbPreviewOrders.SelectedIndex = -1;
                lbPreviewOrders.ItemsSource = null;
                lbPreviewOrders.ItemsSource = orderList;

                EnableNewOrderButtons();
            }
            catch { }
        }

        private void btnCancel1_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            foreach (Order order in orderList)
                if (order.Id == newOrder.Id)
                {
                    DeleteOrder(order);
                    break;
                }

            newOrder = null;
            newOrderItemList = null;
            lbNewOrderItems.ItemsSource = null;

            EnableNewOrderButtons();
        }

        private void btnEdit_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            tabs.SelectedIndex = 1;
            btnNewOrder_Click(sender, e);
        }

        private void btnCancel_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Order order = (sender as Button).DataContext as Order;
            if (order != null)
                DeleteOrder(order);
        }

        private void AddButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                if (newOrder != null)
                {
                    bool found = false;
                    Product newProduct = (sender as Button).DataContext as Product;
                    if (newProduct != null)
                    {
                        foreach (Item item in newOrderItemList)
                            if (item.ProductId == newProduct.Id)
                            {
                                found = true;
                                item.Count++;
                                data.UpdateItem(item);
                                break;
                            }

                        if (!found)
                        {
                            Item item = data.NewItem(newOrder, newProduct, 1);
                            newOrderItemList.Add(item);

                            lbNewOrderItems.ItemsSource = null;
                            lbNewOrderItems.ItemsSource = newOrderItemList;
                        }

                        foreach (Order order in orderList)
                            if (order.Id == newOrder.Id)
                            {
                                order.TotalPrice = data.GetOrderTotalPrice(order);
                                break;
                            }

                        lbPreviewOrders.SelectedIndex = -1;
                        lbPreviewOrders.ItemsSource = null;
                        lbPreviewOrders.ItemsSource = orderList;
                    }
                }
            }
            catch { }
        }

        private void DeleteButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                Item item = (sender as Button).DataContext as Item;
                data.DeleteItem(item);
                newOrderItemList.Remove(item);

                foreach (Order order in orderList)
                    if (order.Id == newOrder.Id)
                    {
                        order.TotalPrice = data.GetOrderTotalPrice(order);
                    }

                lbNewOrderItems.ItemsSource = null;
                lbNewOrderItems.ItemsSource = newOrderItemList;
            }
            catch { }
        }

        private void EnableNewOrderButtons()
        {
            btnNewOrder.IsEnabled = newOrder == null;
            btnAccept.IsEnabled =
            btnCancel.IsEnabled = newOrder != null;
        }

        private void DeleteOrder(Order order)
        {
            try
            {
                data.CancelOrder(order);
                orderList.Remove(order);

                lbPreviewOrders.SelectedIndex = -1;
                lbPreviewOrders.ItemsSource = null;
                lbPreviewOrders.ItemsSource = orderList;
            }
            catch { }
        }

        private void GetOrderList()
        {
            try
            {
                orderList = data.GetOrders(customer, orderRecords);
                lbPreviewOrders.ItemsSource = orderList;
            }
            catch { }
        }

        private void GetProductList()
        {
            try
            {
                productList = data.GetProducts(new RecordInfo { Start = 1, Count = 999999 });
                foreach (Product product in productList)
                    if (!product.IsActive)
                        productList.Remove(product);
                lbProducts.ItemsSource = productList;
            }
            catch { }
        }

        public IDataConnection Data
        {
            set
            {
                data = value;
                ctrlEditCustomer.Data = value;
            }
        }

        public Customer Customer
        {
            set
            {
                customer = value;
                ctrlEditCustomer.Customer = value;
            }
        }
    }
}
