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
    public partial class UploadSampleDialog : UserControl
    {
        private DataProvider dataProvider;

        public UploadSampleDialog()
        {
            InitializeComponent();
        }

        private void btnImage_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Filter = "Image Files (*.bmp, *.jpg, *.png)|*.bmp;*.jpg;*.png";
            if (dlg.ShowDialog() == true)
            {
                dataProvider.UploadData.Image = dlg.File;
            }
        }

        private void btnPoints_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*";
            if (dlg.ShowDialog() == true)
            {
                dataProvider.UploadData.Points = dlg.File;
            }
        }

        private void btnUpload_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Hide();
            dataProvider.UploadSample(cbSurfaces.SelectedItem as SurfaceData);
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
            DataContext = dataProvider.UploadData;
        }
    }
}
