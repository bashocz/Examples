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
    /// Interaction logic for ProductEditControl.xaml
    /// </summary>
    public partial class ProductEditControl : UserControl
    {
        private IDataConnection data;

        private Product productBackup;
        private Product product;

        public ProductEditControl()
        {
            InitializeComponent();

            btnSave.Click += new RoutedEventHandler(btnSave_Click);
            btnCancel.Click += new RoutedEventHandler(btnCancel_Click);
        }

        private void btnSave_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                if (productBackup == null)
                {
                    productBackup = data.NewProduct(product.Name, product.Price, product.TimeConsuming);
                    product.Id = productBackup.Id;
                }
                else
                {
                    data.UpdateProduct(product, productBackup);
                    productBackup.Name = product.Name;
                    productBackup.Price = product.Price;
                    productBackup.TimeConsuming = product.TimeConsuming;
                    productBackup.Active = product.Active;
                }
            }
            catch { }
        }

        private void btnCancel_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            EditProduct(productBackup);
        }

        private void EditProduct(Product editProduct)
        {
            product = new Product();
            if (editProduct != null)
            {
                product.Id = editProduct.Id;
                product.Name = editProduct.Name;
                product.Price = editProduct.Price;
                product.TimeConsuming = editProduct.TimeConsuming;
                product.Active = editProduct.Active;
            }
            gridEdit.DataContext = product;
        }

        public IDataConnection Data
        {
            set { data = value; }
        }

        public Product Product
        {
            set
            {
                productBackup = value;
                EditProduct(value);
            }
        }
    }
}
