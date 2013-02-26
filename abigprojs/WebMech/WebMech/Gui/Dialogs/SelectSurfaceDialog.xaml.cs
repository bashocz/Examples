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
using WebMech.WebMechService;

namespace WebMech
{
    public partial class SelectSurfaceDialog : UserControl
    {
        private DataProvider dataProvider;

        public SelectSurfaceDialog()
        {
            InitializeComponent();
        }

        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {
            Hide();
            dataProvider.SurfaceFilter.Start = 1;
            dataProvider.GetSurfaceList();
        }

        private void btnCancel_Click(object sender, System.Windows.RoutedEventArgs e)
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

        public void SetDataProvider(DataProvider dataProvider)
        {
            this.dataProvider = dataProvider;
            DataContext = dataProvider.SurfaceFilter;
        }
    }
}
