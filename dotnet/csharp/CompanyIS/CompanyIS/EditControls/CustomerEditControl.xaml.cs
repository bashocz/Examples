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
    /// Interaction logic for CustomerEditControl.xaml
    /// </summary>
    public partial class CustomerEditControl : UserControl
    {
        private IDataConnection data;

        private Customer customerBackup;
        private Customer customer;

        public CustomerEditControl()
        {
            InitializeComponent();

            btnSave.Click += new RoutedEventHandler(btnSave_Click);
            btnCancel.Click += new RoutedEventHandler(btnCancel_Click);
        }

        private void btnSave_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                if (customerBackup == null)
                {
                    customerBackup = data.NewCustomer(customer.Name, customer.Street, customer.Number,
                        customer.City, customer.Psc, customer.Phone);
                    customer.Id = customerBackup.Id;
                }
                else
                {
                    data.UpdateCustomer(customer, customerBackup);
                    customerBackup.Name = customer.Name;
                    customerBackup.Street = customer.Street;
                    customerBackup.Number = customer.Number;
                    customerBackup.City = customer.City;
                    customerBackup.Psc = customer.Psc;
                    customerBackup.Phone = customer.Phone;
                    customerBackup.Active = customer.Active;
                }
            }
            catch
            {

            }
        }

        private void btnCancel_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            EditCustomer(customerBackup);
        }

        private void EditCustomer(Customer editCustomer)
        {
            customer = new Customer();
            if (editCustomer != null)
            {
                customer.Id = editCustomer.Id;
                customer.Name = editCustomer.Name;
                customer.Street = editCustomer.Street;
                customer.Number = editCustomer.Number;
                customer.City = editCustomer.City;
                customer.Psc = editCustomer.Psc;
                customer.Phone = editCustomer.Phone;
                customer.Active = editCustomer.Active;
            }
            gridEdit.DataContext = customer;
        }

        public void CanActive(bool active)
        {
            if (active)
                cbActive.Visibility = Visibility.Visible;
            else
                cbActive.Visibility = Visibility.Collapsed;
        }

        public IDataConnection Data
        {
            set { data = value; }
        }

        public Customer Customer
        {
            set
            {
                customerBackup = value;
                EditCustomer(value);
            }
        }
    }
}
