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
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private IDataConnection data;

        private User user;

        public MainWindow()
        {
            InitializeComponent();

            Loaded += new RoutedEventHandler(MainWindow_Loaded);
            btnLogin.Click += new RoutedEventHandler(btnLogin_Click);
        }

        private void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            data = new OracleDataConnection();

            ctrlCustomer.Data = data;
            ctrlSales.Data = data;
            ctrlProduction.Data = data;

            Login();
        }

        private void btnLogin_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            if (user == null)
                Login();
            else
                Logout();
        }

        private void Login()
        {
            LoginWindow win = new LoginWindow();
            win.ShowDialog();
            string name = win.txtName.Text;
            string password = win.txtPassword.Password;
            win.Close();

            user = data.AuthorizeUser(name, password);
            EnableControls();
        }

        private void Logout()
        {
            user = null;
            EnableControls();
        }

        private void EnableControls()
        {
            gridLogin.DataContext = user;
            ctrlCustomer.Visibility = Visibility.Collapsed;
            ctrlSales.Visibility = Visibility.Collapsed;
            ctrlProduction.Visibility = Visibility.Collapsed;
            if (user == null)
                btnLogin.Content = "Login";
            else
            {
                btnLogin.Content = "Logout";

                switch (user.Role)
                {
                    case Role.Zakaznik:
                        ctrlCustomer.Customer = user.Customer;
                        ctrlCustomer.Visibility = Visibility.Visible;
                        break;
                    case Role.Obchodnik:
                        ctrlSales.Visibility = Visibility.Visible;
                        break;
                    case Role.Vyroba:
                        ctrlProduction.Visibility = Visibility.Visible;
                        break;
                }
            }
        }
    }
}
