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
using System.Windows.Shapes;

namespace Basho
{
    /// <summary>
    /// Interaction logic for LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();

            Loaded += new RoutedEventHandler(LoginWindow_Loaded);

            btnOk.Click += new RoutedEventHandler(btnOk_Click);
            btnCancel.Click += new RoutedEventHandler(btnCancel_Click);
        }

        private void LoginWindow_Loaded(object sender, RoutedEventArgs e)
        {
            txtName.Focus();
        }

        private void btnOk_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            DialogResult = true;
        }

        private void btnCancel_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            DialogResult = false;
        }
    }
}
