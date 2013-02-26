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
using System.ComponentModel.DataAnnotations;
using WebMech.WebMechService;

namespace WebMech
{
    public partial class DeleteDialog : UserControl
    {
        private DataProvider dataProvider;
        private SurfaceData surface;
        private SampleData sample;

        public DeleteDialog()
        {
            InitializeComponent();
        }

        private void btnYes_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            if (surface != null)
            {
                dataProvider.DeleteSurface(surface);
            }
            else if (sample != null)
            {
                dataProvider.DeleteSample(sample);
            }
            Hide();
        }

        private void btnNo_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Hide();
        }

        public void Show(SurfaceData surface)
        {
            this.surface = surface;
            lblMessage.Text = "Opravdu chccete smazat vybraný povrch z databáze";
            Visibility = Visibility.Visible;
        }

        public void Show(SampleData sample)
        {
            this.sample = sample;
            lblMessage.Text = "Opravdu chccete smazat vybraný vzorek z databáze";
            Visibility = Visibility.Visible;
        }

        public void Hide()
        {
            surface = null;
            sample = null;
            Visibility = Visibility.Collapsed;
        }

        public void SetDataProvider(DataProvider dataProvider)
        {
            this.dataProvider = dataProvider;
        }
    }
}
