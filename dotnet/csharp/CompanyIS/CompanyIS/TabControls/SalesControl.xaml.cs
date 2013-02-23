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

namespace Basho
{
    /// <summary>
    /// Interaction logic for SalesControl.xaml
    /// </summary>
    public partial class SalesControl : UserControl
    {
        private IDataConnection data;

        private List<Customer> customerList;

        private List<Product> productList;

        private List<Item> storeList;

        private List<Plan> planList;

        private List<Order> orderList;

        private List<User> userList;

        private RecordInfo customerRecords = new RecordInfo { Start = 1, Count = 10 };
        private RecordInfo productRecords = new RecordInfo { Start = 1, Count = 10 };
        private RecordInfo storeRecords = new RecordInfo { Start = 1, Count = 10 };
        private RecordInfo planRecords = new RecordInfo { Start = 1, Count = 10 };
        private RecordInfo orderRecords = new RecordInfo { Start = 1, Count = 10 };
        private RecordInfo userRecords = new RecordInfo { Start = 1, Count = 10 };
        
        public SalesControl()
        {
            InitializeComponent();

            IsVisibleChanged += new DependencyPropertyChangedEventHandler(SalesControl_IsVisibleChanged);

            ctrlEditUser.UserAdded += new UserEditControl.UserAddedDelegate(ctrlEditUser_UserAdded);

            pnlCustomerRecords.DataContext = customerRecords;
            pnlProductRecords.DataContext = productRecords;
            pnlStoreRecords.DataContext = storeRecords;
            pnlPlanRecords.DataContext = planRecords;
            pnlOrderRecords.DataContext = orderRecords;
            pnlUserRecords.DataContext = userRecords;
        }

        private void SalesControl_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                tabs.SelectedIndex = 0;
            }
        }

        private void gridCustomers_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (tabs.SelectedIndex == 0)
            {
                GetCustomerList();
            }
        }

        private void gridProducts_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (tabs.SelectedIndex == 1)
            {
                GetProductList();
            }
        }

        private void gridStores_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (tabs.SelectedIndex == 2)
            {
                GetStoreList();
            }
        }

        private void gridPlans_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (tabs.SelectedIndex == 3)
            {
                GetPlanList();
            }
        }

        private void gridOrders_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (tabs.SelectedIndex == 4)
            {
                GetOrderList();
            }
        }

        private void gridUsers_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (tabs.SelectedIndex == 5)
            {
                GetUserList();
                ctrlEditUser.Initialize();
            }
        }

        private void lbCustomers_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            ctrlEditCustomer.Customer = lbCustomers.SelectedItem as Customer;
        }

        private void tbCustomerCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                customerRecords.Start = 1;
                GetCustomerList();
                e.Handled = true;
            }
        }

        private void btnCustomerPrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            customerRecords.Start -= customerRecords.Count;
            GetCustomerList();
        }

        private void btnCustomerNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            customerRecords.Start += customerRecords.Count;
            GetCustomerList();
        }

        private void btnNewCustomer_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                string customerName = "Zákazník";
                int idx = 0;
                bool exist = true;
                while (exist)
                {
                    exist = false;
                    foreach (Customer customer in customerList)
                        if (string.Compare(customer.Name, customerName, true) == 0)
                        {
                            exist = true;
                            break;
                        }
                    if (exist)
                    {
                        idx++;
                        customerName = "Zákazník " + idx.ToString("00");
                    }
                }

                Customer newCustomer = data.NewCustomer(customerName, "Ulice", 0, "Město", 10000, "600000000");

                customerList.Add(newCustomer);

                lbCustomers.ItemsSource = null;
                lbCustomers.ItemsSource = customerList;
            }
            catch { }
        }

        private void lblProducts_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            ctrlEditProduct.Product = lbProducts.SelectedItem as Product;
        }

        private void tbProductCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                productRecords.Start = 1;
                GetProductList();
                e.Handled = true;
            }
        }

        private void btnProductPrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            productRecords.Start -= productRecords.Count;
            GetProductList();
        }

        private void btnProductNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            productRecords.Start += productRecords.Count;
            GetProductList();
        }

        private void btnNewProduct_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                string productName = "Výrobek";
                int idx = 0;
                bool exist = true;
                while (exist)
                {
                    exist = false;
                    foreach (Product product in productList)
                        if (string.Compare(product.Name, productName, true) == 0)
                        {
                            exist = true;
                            break;
                        }
                    if (exist)
                    {
                        idx++;
                        productName = "Výrobek " + idx.ToString("00");
                    }
                }

                Product newProduct = data.NewProduct(productName, 99, 1.5);

                productList.Add(newProduct);

                lbProducts.ItemsSource = null;
                lbProducts.ItemsSource = productList;
            }
            catch { }
        }

        private void tbStoreCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                storeRecords.Start = 1;
                GetStoreList();
                e.Handled = true;
            }
        }

        private void tbnStorePrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            storeRecords.Start -= storeRecords.Count;
            GetStoreList();
        }

        private void btnStoreNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            storeRecords.Start += storeRecords.Count;
            GetStoreList();
        }

        private void btnStoreUpdate_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            GetStoreList();
        }

        private void tbPlanCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                planRecords.Start = 1;
                GetPlanList();
                e.Handled = true;
            }
        }

        private void btnPlanPrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            planRecords.Start -= planRecords.Count;
            GetPlanList();
        }

        private void btnPlanNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            planRecords.Start += planRecords.Count;
            GetPlanList();
        }

        private void btnPlanUpdate_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            GetPlanList();
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

        private void lbOrders_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            lbOrderItems.ItemsSource = null;

            if (lbOrders.SelectedItem != null)
                lbOrderItems.ItemsSource = data.GetItems(lbOrders.SelectedItem as Order);
        }

        private void btnOrderUpdate_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            GetOrderList();
        }

        private void btnOrderSend_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                Order order = (sender as Button).DataContext as Order;
                data.SendOrder(order);
                order.State = "Odeslano"; 
            }
            catch { }
        }

        private void tbUserCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                userRecords.Start = 1;
                GetUserList();
                e.Handled = true;
            }
        }

        private void btnUserPrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            userRecords.Start -= userRecords.Count;
            GetUserList();
        }

        private void btnUserNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            userRecords.Start += userRecords.Count;
            GetUserList();
        }

        private void ctrlEditUser_UserAdded()
        {
            GetUserList();
        }

        public void GetCustomerList()
        {
            try
            {
                customerList = data.GetCustomers(customerRecords);
                lbCustomers.ItemsSource = customerList;
            }
            catch { }
        }

        public void GetProductList()
        {
            try
            {
                productList = data.GetProducts(productRecords);
                lbProducts.ItemsSource = productList;
            }
            catch { }
        }

        public void GetStoreList()
        {
            try
            {
                storeList = data.GetStore(storeRecords);
                lbStores.ItemsSource = storeList;
            }
            catch { }
        }

        public void GetPlanList()
        {
            try
            {
                planList = data.GetPlans(planRecords);
                lbPlans.ItemsSource = planList;
            }
            catch { }
        }

        public void GetOrderList()
        {
            try
            {
                orderList = data.GetOrders(orderRecords);
                lbOrders.ItemsSource = orderList;
            }
            catch { }
        }

        public void GetUserList()
        {
            try
            {
                userList = data.GetUsers(userRecords);
                lbUsers.ItemsSource = userList;
            }
            catch { }
        }

        public IDataConnection Data
        {
            set
            {
                data = value;
                ctrlEditCustomer.Data = value;
                ctrlEditProduct.Data = value;
                ctrlEditUser.Data = value;
            }
        }
    }
}
