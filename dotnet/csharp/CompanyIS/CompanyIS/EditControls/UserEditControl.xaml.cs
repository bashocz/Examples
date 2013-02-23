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
    /// Interaction logic for UserEditControl.xaml
    /// </summary>
    public partial class UserEditControl : UserControl
    {
        private IDataConnection data;

        public UserEditControl()
        {
            InitializeComponent();

            btnSave.Click += new RoutedEventHandler(btnSave_Click);
        }

        private void btnSave_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                Role role = (Role)cbRoles.SelectedItem;
                Nullable<int> customerId = null;
                if (cbCustomers.SelectedIndex > 0)
                    customerId = (cbCustomers.SelectedItem as Customer).Id;
                User user = data.NewUser(tbName.Text, tbPassword.Password, role, customerId);
                
                if (UserAdded != null)
                    UserAdded();
            }
            catch { }
        }

        public delegate void UserAddedDelegate();
        public event UserAddedDelegate UserAdded;

        public void Initialize()
        {
            List<Role> roleList = new List<Role>();
            roleList.Add(Role.Zakaznik);
            roleList.Add(Role.Obchodnik);
            roleList.Add(Role.Vyroba);
            cbRoles.ItemsSource = roleList;

            cbCustomers.ItemsSource = data.GetCustomers(new RecordInfo { Start = 1, Count = 999999 });
        }

        public IDataConnection Data
        {
            set { data = value; }
        }
    }
}
