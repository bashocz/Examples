using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace WebMech
{
    public partial class UnderConstructionDialog : UserControl
    {
        public UnderConstructionDialog()
        {
            InitializeComponent();
        }

        private void btnOk_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Hide();
        }

        public void Show()
        {
            Visibility = Visibility.Visible;
        }

        public void Hide()
        {
            Visibility = Visibility.Collapsed;
        }
    }
}
