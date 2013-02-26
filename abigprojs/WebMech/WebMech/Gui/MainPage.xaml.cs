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
using System.Collections.ObjectModel;
using System.IO;
using System.Reflection;

namespace WebMech
{
    public partial class MainPage : UserControl
    {
        private DataProvider dataProvider;

        public MainPage()
        {
            InitializeComponent();
        }

        private void UserControl_Loaded(object sender, System.Windows.RoutedEventArgs e)
        {
            dataProvider = new DataProvider();

            DataContext = dataProvider;
            pageViewSurface.SetDataProvider(dataProvider, dlgDelete);
            dlgSelectSurface.SetDataProvider(dataProvider);
            dlgNewSurface.SetDataProvider(dataProvider);
            dlgUploadSample.SetDataProvider(dataProvider);
            dlgDelete.SetDataProvider(dataProvider);
            dlgProgress.SetDataProvider(dataProvider);
        }

        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {
            dlgSelectSurface.Show();
        }

        private void btnNew_Click(object sender, RoutedEventArgs e)
        {
            dlgNewSurface.Show();
        }

        private void btnUpload_Click(object sender, RoutedEventArgs e)
        {
            dataProvider.UploadData.Image = null;
            dataProvider.UploadData.Points = null;
            dlgUploadSample.Show();
        }

        private void btnDocumentation_Click(object sender, RoutedEventArgs e)
        {
            dlgUnderConstruction.Show();
        }
    }
}
