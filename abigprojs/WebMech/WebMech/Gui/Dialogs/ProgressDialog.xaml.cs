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
    public partial class ProgressDialog : UserControl
    {
        public ProgressDialog()
        {
            InitializeComponent();
        }

        private void btnOk_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Hide();
        }

        private void Show(object sender, OperationStartedEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.Message))
                tbMessage.Text = e.Message;
            else
                tbMessage.Text = "Stahování ...";
            spDownload.Visibility = Visibility.Visible;
            gridException.Visibility = Visibility.Collapsed;
            Visibility = Visibility.Visible;
        }

        private void ShowException(object sender, OperationFailedEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.Exception))
                tbException.Text = e.Exception;
            else
                tbException.Text = "Unknown exception";
            spDownload.Visibility = Visibility.Collapsed;
            gridException.Visibility = Visibility.Visible;
            Visibility = Visibility.Visible;
        }

        private void Hide(object sender, OperationCompletedEventArgs e)
        {
            Visibility = Visibility.Collapsed;
        }

        public void Show()
        {
            Show(this, new OperationStartedEventArgs());
        }

        public void Hide()
        {
            Hide(this, new OperationCompletedEventArgs());
        }

        public void ShowException()
        {
            ShowException(this, new OperationFailedEventArgs());
        }

        public void SetDataProvider(DataProvider dataProvider)
        {
            dataProvider.OperationStarted += new EventHandler<OperationStartedEventArgs>(Show);
            dataProvider.OperationCompleted += new EventHandler<OperationCompletedEventArgs>(Hide);
            dataProvider.OperationFailed += new EventHandler<OperationFailedEventArgs>(ShowException);
        }

        public void ResetDataProvider(DataProvider dataProvider)
        {
            dataProvider.OperationStarted -= new EventHandler<OperationStartedEventArgs>(Show);
            dataProvider.OperationCompleted -= new EventHandler<OperationCompletedEventArgs>(Hide);
            dataProvider.OperationFailed -= new EventHandler<OperationFailedEventArgs>(ShowException);
        }
    }
}
