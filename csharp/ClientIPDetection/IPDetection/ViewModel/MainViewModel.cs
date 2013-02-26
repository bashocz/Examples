using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Command;
using IPDetection.IpDetectionServiceReference;
using System.Windows.Threading;
using System.Windows;

namespace IPDetection.ViewModel
{
    public class MainViewModel : ViewModelBase
    {
        private readonly IpDetectionServiceClient client;
        public MainViewModel()
        {
            client = new IpDetectionServiceClient();
        }


        private string _ipAddress;
        public string IpAddress
        {
            get { return string.Format("IP adresa klienta: {0}", _ipAddress); }
            set
            {
                if (value != _ipAddress)
                {
                    _ipAddress = value;
                    RaisePropertyChanged(() => this.IpAddress);
                }
            }
        }

        private string _controlIpAddress;
        public string ControlIpAddress
        {
            get { return string.Format("IP adresa kontrolora: {0}", _controlIpAddress); }
            set
            {
                if (value != _controlIpAddress)
                {
                    _controlIpAddress = value;
                    RaisePropertyChanged(() => this.ControlIpAddress);
                }
            }
        }

        private bool _isController;
        public string IsController
        {
            get { return string.Format("Je kontrolor: {0}", _isController); }
        }

        void SetController(bool value)
        {
            if (value != _isController)
            {
                _isController = value;
                RaisePropertyChanged(() => this.IsController);
            }
        }

        private RelayCommand _command;
        public RelayCommand Command
        {
            get { return _command ?? (_command = new RelayCommand(() => { CallWcf(); })); }
        }

        private void CallWcf()
        {
            client.GetClientInfoCompleted += new System.EventHandler<GetClientInfoCompletedEventArgs>(client_GetClientInfoCompleted);
            client.GetClientInfoAsync();
        }

        void client_GetClientInfoCompleted(object sender, GetClientInfoCompletedEventArgs e)
        {
            if (e.Error != null)
                return;

            if (Deployment.Current.Dispatcher.CheckAccess())
                UpdateControls(e.Result);
            else
                Deployment.Current.Dispatcher.BeginInvoke(() =>
                {
                    UpdateControls(e.Result);
                });
        }

        private void UpdateControls(ClientInfo clientInfo)
        {
            IpAddress = clientInfo.IpAddress;
            ControlIpAddress = clientInfo.ControlIpAddress;
            SetController(clientInfo.IsController);
        }
    }
}