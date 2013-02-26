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

namespace WebMech
{
    public partial class NewSurfaceDialog : UserControl
    {
        private DataProvider dataProvider;

        public NewSurfaceDialog()
        {
            InitializeComponent();
        }

        private void btnOk_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            var validationContext = new ValidationContext(DataContext, null, null);
            List<ValidationResult> validationResults = new List<ValidationResult>();

            if (!Validator.TryValidateObject(DataContext, validationContext, validationResults))
            {
                //Validation failed
                lblError.Visibility = Visibility.Visible;
            }
            else
            {
                //Validation passed    
                Hide();
                dataProvider.AddSurface();
            }
        }

        private void btnCancel_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Hide();
        }

        public void Show()
        {
            try { dataProvider.NewSurface.Name = ""; }
            catch { }
            lblError.Visibility = Visibility.Collapsed;
            Visibility = Visibility.Visible;
        }

        public void Hide()
        {
            Visibility = Visibility.Collapsed;
        }

        public void SetDataProvider(DataProvider dataProvider)
        {
            this.dataProvider = dataProvider;
            DataContext = dataProvider.NewSurface;
        }
    }
}
