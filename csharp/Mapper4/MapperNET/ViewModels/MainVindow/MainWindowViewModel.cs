using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Input;
using Mapper.Common;
using Mapper.Core;
using System.Threading.Tasks;

namespace Mapper.GUI
{
    public class MainWindowViewModel : NotifiableObject
    {
        #region private fields

        private readonly IProgramData _programData;
        private readonly ICoreManager _coreManager;

        #endregion

        #region construtors

        public MainWindowViewModel(IProgramData programData, ICoreManager coreManager)
        {
            _programData = programData;
            _coreManager = coreManager;

            RegisterModel();
            RegisterCommands();
        }

        ~MainWindowViewModel()
        {
            UnregisterModel();
        }

        #endregion // construtors

        #region private methods - IProgramData model

        private void RegisterModel()
        {
            _programData.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(_programData_PropertyChanged);
            _coreManager.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(_coreManager_PropertyChanged);
        }

        private void UnregisterModel()
        {
            _programData.PropertyChanged -= new System.ComponentModel.PropertyChangedEventHandler(_programData_PropertyChanged);
            _coreManager.PropertyChanged -= new System.ComponentModel.PropertyChangedEventHandler(_coreManager_PropertyChanged);
        }

        void _programData_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            RaisePropertyChanged(e.PropertyName);
            CommandManager.InvalidateRequerySuggested();
        }

        void _coreManager_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName.Equals("State"))
            {
                RaisePropertyChanged("ProcessState");
                StartProcessCommand.RaiseCanExecuteChanged();
            }
        }

        #endregion // private methods - IProgramData model

        #region private methods - commands

        private void RegisterCommands()
        {
            CloseCommand = new RelayCommand(p => Close());
            CheckinCommand = new RelayCommand(p => Checkin(), p => CanCheckin);
            CheckoutCommand = new RelayCommand(p => Checkout(), p => CanCheckout);
            StartProcessCommand = new RelayCommand(p => StartProcess(), p => CanStartProcess);
        }

        private void Close()
        {
            Application app = Application.Current;
            app.Shutdown();
        }

        private void Checkin()
        {
            _programData.Lot = new Lot("ABC123456");
        }

        public bool CanCheckin
        {
            get { return (_programData == null) ? false : _programData.Lot == null; }
        }

        private void Checkout()
        {
            _programData.Lot = null;
        }

        public bool CanCheckout
        {
            get { return (_programData == null) ? false : _programData.Lot != null; }
        }

        private void StartProcess()
        {
            Task task = Task.Factory.StartNew(() =>
            {
                _coreManager.StartProcess();
            });
        }

        public bool CanStartProcess
        {
            get
            {
                bool canStart = false;
                if ((_programData != null) && (_programData.Lot != null) &&
                    (_coreManager != null) && (_coreManager.State == ProcessState.Idle))
                    canStart = true;
                return canStart;
            }
        }

        public IRelayCommand CloseCommand { get; private set; }
        public IRelayCommand CheckinCommand { get; private set; }
        public IRelayCommand CheckoutCommand { get; private set; }
        public IRelayCommand StartProcessCommand { get; private set; }

        #endregion // private methods - commands

        #region public properties

        public IProgramData ProgramData
        {
            get { return _programData; }
        }

        public ILot Lot
        {
            get { return _programData.Lot; }
        }

        public ProcessState ProcessState
        {
            get { return _coreManager.State; }
        }

        #endregion // public properties
    }
}
