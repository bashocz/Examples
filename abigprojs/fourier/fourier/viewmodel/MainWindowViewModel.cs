using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Input;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using System.Drawing;
using System.Numerics;
using Fourier.Domain;
using System.Windows.Media.Imaging;
using System.Windows.Threading;
using System.Windows.Media;
using System.Threading;

namespace Fourier.ViewModel
{
    class MainWindowViewModel : NotifiableObject, IProgress
    {
        #region constructors

        public MainWindowViewModel(Dispatcher dispatcher)
        {
            _dispatcher = dispatcher;
        }

        #endregion

        #region commands

        private IRelayCommand _closeCommand;
        public IRelayCommand CloseCommand
        {
            get { return _closeCommand ?? (_closeCommand = new RelayCommand(c => Close(), c => CanClose)); }
        }

        private IRelayCommand _openImage;
        public IRelayCommand OpenImageCommand
        {
            get { return _openImage ?? (_openImage = new RelayCommand(c => OpenImage(), c => CanOpenImage)); }
        }

        private IRelayCommand _closeImage;
        public IRelayCommand CloseImageCommand
        {
            get { return _closeImage ?? (_closeImage = new RelayCommand(c => CloseImage(), c => CanCloseImage)); }
        }

        private IRelayCommand _processImage;
        public IRelayCommand ProcessImageCommand
        {
            get { return _processImage ?? (_processImage = new RelayCommand(c => ProcessImage(), c => CanProcessImage)); }
        }

        private IRelayCommand _cancelProcessImage;
        public IRelayCommand CancelProcessImageCommand
        {
            get { return _cancelProcessImage ?? (_cancelProcessImage = new RelayCommand(c => CancelProcessImage(), c => CanCancelProcessImage)); }
        }

        private List<IRelayCommand> _commands;
        public IList<IRelayCommand> Commands
        {
            get
            {
                if (_commands == null)
                {
                    _commands = new List<IRelayCommand>();
                    _commands.Add(CloseCommand);
                    _commands.Add(OpenImageCommand);
                    _commands.Add(CloseImageCommand);
                    _commands.Add(ProcessImageCommand);
                    _commands.Add(CancelProcessImageCommand);
                }
                return _commands;
            }
        }

        private void Close()
        {
            Application.Current.Shutdown();
        }

        private bool CanClose
        {
            get { return !ProcessRunning; }
        }

        private void OpenImage()
        {
            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog();
            dlg.Filter = "Image files (*.gif;*.jpg;*.jpe;*.png;*.bmp;*.dib;*.tif;*.wmf;*.ras;*.eps;*.pcx;*psd;*.tga)|*.gif;*.jpg;*.jpe;*.png;*.bmp;*.dib;*.tif;*.wmf;*.ras;*.eps;*.pcx;*psd;*.tga";

            Nullable<bool> result = dlg.ShowDialog();

            if (result == true)
            {
                Task task = Task.Factory.StartNew(() =>
                {
                    OpenImageTask(dlg.FileName);
                });
            }
        }

        private bool CanOpenImage
        {
            get { return !ProcessRunning; }
        }

        private void CloseImage()
        {
            Task task = Task.Factory.StartNew(() =>
            {
                CloseImageTask();
            });
        }

        private bool CanCloseImage
        {
            get { return ImageLoaded && !ProcessRunning; }
        }

        private void ProcessImage()
        {
            ProcessCancelTokenSource = new CancellationTokenSource();
            var ct = ProcessCancelTokenSource.Token;
            Task task = Task.Factory.StartNew(() =>
            {
                ProcessImageTask(ct);
            }, ct);
        }

        private bool CanProcessImage
        {
            get { return ImageLoaded && !ProcessRunning; }
        }

        private void CancelProcessImage()
        {
            if (ProcessCancelTokenSource != null)
                ProcessCancelTokenSource.Cancel();
        }

        private bool CanCancelProcessImage
        {
            get { return ProcessRunning; }
        }

        private void RaiseCanCommands()
        {
            foreach (IRelayCommand command in Commands)
                command.RaiseCanExecuteChanged();
        }

        #endregion // commands

        #region process image

        #region ImageTask nested class

        enum SignalType
        {
            Origin = 0,
            Fourier,
            Filter,
            FourierAndFilter,
            ReverseFourier
        }

        class SignalInfo
        {
            public SignalInfo(string caption, SignalType signalType, Complex[,] signal)
            {
                Caption = caption;
                SignalType = signalType;
                Signal = signal;
            }

            public string Caption { get; private set; }
            public SignalType SignalType { get; private set; }
            public Complex[,] Signal { get; private set; }
        }

        class SignalTaskInfo
        {
            public SignalTaskInfo(string caption, SignalType signalType, Func<IEnumerable<SignalInfo>, Complex[,]> action)
            {
                Caption = caption;
                SignalType = signalType;
                Action = action;
            }

            public string Caption { get; private set; }
            public SignalType SignalType { get; private set; }
            public Func<IEnumerable<SignalInfo>, Complex[,]> Action { get; private set; }
        }

        #endregion

        private Dispatcher _dispatcher;

        private void OpenImageTask(string fileName)
        {
            CloseImageTask();
            OriginImage = new ImageViewModel("Původní obrázek", new Bitmap(fileName));
            AddOriginImageToList();
        }

        private void CloseImageTask()
        {
            OriginImage = null;
            ClearImageList();
        }

        private void ProcessImageTask(CancellationToken ct)
        {
            ClearImageList();
            AddOriginImageToList();

            List<SignalInfo> signals = new List<SignalInfo>();
            signals.Add(new SignalInfo("Původní obrázek", SignalType.Origin, ImageHelper.GetSignal(OriginImage.Bitmap)));

            List<SignalTaskInfo> tasks = new List<SignalTaskInfo>();
            tasks.Add(new SignalTaskInfo("Fourierova transformace", SignalType.Fourier, new Func<IEnumerable<SignalInfo>, Complex[,]>((s) =>
                {
                    SignalInfo originInfo = s.Where(si => si.SignalType == SignalType.Origin).FirstOrDefault();
                    if (originInfo != null)
                        return FourierTransform.Transform(originInfo.Signal, FourierType, this, ct);
                    throw new ArgumentException("Origin signal does not exist in the list.");
                })));
            if (FilterType != FilterType.None)
            {
                tasks.Add(new SignalTaskInfo("Filtr", SignalType.Filter, new Func<IEnumerable<SignalInfo>, Complex[,]>((s) =>
                {
                    SignalInfo fourierInfo = s.Where(si => si.SignalType == SignalType.Fourier).FirstOrDefault();
                    if (fourierInfo != null)
                        return Filter.GetFilter(fourierInfo.Signal, FilterType, FilterIsFromCenter, FilterLimit1, FilterLimit2, this, ct);
                    throw new ArgumentException("Fourier signal does not exist in the list.");
                })));
                tasks.Add(new SignalTaskInfo("Aplikovaný filtr", SignalType.FourierAndFilter, new Func<IEnumerable<SignalInfo>, Complex[,]>((s) =>
                {
                    SignalInfo fourierInfo = s.Where(si => si.SignalType == SignalType.Fourier).FirstOrDefault();
                    SignalInfo filterInfo = s.Where(si => si.SignalType == SignalType.Filter).FirstOrDefault();
                    if ((fourierInfo != null) && (filterInfo != null))
                        return Filter.ApplyFilter(fourierInfo.Signal, filterInfo.Signal, this, ct);
                    throw new ArgumentException("Fourier or filter signal does exist in the list.");
                })));
            }
            tasks.Add(new SignalTaskInfo("Fourierova transformace", SignalType.Fourier, new Func<IEnumerable<SignalInfo>, Complex[,]>((s) =>
            {
                SignalInfo signalInfo = s.LastOrDefault();
                if (signalInfo != null)
                    return FourierTransform.ReverseTransform(signalInfo.Signal, FourierType, this, ct);
                throw new ArgumentException("Any signal does not exist in the list.");
            })));

            foreach (SignalTaskInfo taskInfo in tasks)
            {
                TaskCaption = taskInfo.Caption;
                Complex[,] signalek = taskInfo.Action(signals);
                signals.Add(new SignalInfo(taskInfo.Caption, taskInfo.SignalType, signalek));
                if (!ct.IsCancellationRequested)
                    AddImageToList(TaskCaption, signalek);
            }

            TaskCaption = null;
            ProcessCancelTokenSource = null;
        }

        private void ClearImageList()
        {
            _dispatcher.Invoke(new Action(() =>
            {
                Images.Clear();
            }), DispatcherPriority.Normal);

        }

        private void AddOriginImageToList()
        {
            _dispatcher.Invoke(new Action(() =>
            {
                Images.Add(OriginImage);
            }), DispatcherPriority.Normal);

        }

        private void AddImageToList(string caption, Complex[,] signal)
        {
            _dispatcher.Invoke(new Action(() =>
            {
                Images.Add(new ImageViewModel(caption, ImageHelper.GetBitmap(signal)));
            }), DispatcherPriority.Normal);
        }

        private ImageViewModel _originImage;
        private ImageViewModel OriginImage
        {
            get { return _originImage; }
            set
            {
                if (_originImage != value)
                {
                    _originImage = value;
                    RaisePropertyChanged("ImageLoaded");
                    RaiseCanCommands();
                }
            }
        }

        public bool ImageLoaded
        {
            get { return OriginImage != null; }
        }

        private CancellationTokenSource _processCancelTokenSource;
        private CancellationTokenSource ProcessCancelTokenSource
        {
            get { return _processCancelTokenSource; }
            set
            {
                if (_processCancelTokenSource != value)
                {
                    _processCancelTokenSource = value;
                    RaisePropertyChanged("ProcessRunning");
                    RaiseCanCommands();
                }
            }
        }

        public bool ProcessRunning
        {
            get { return ProcessCancelTokenSource != null; }
        }

        private FourierType _fourierType = FourierType.MatrixCalculation;
        public FourierType FourierType
        {
            get { return _fourierType; }
            set
            {
                if (_fourierType != value)
                {
                    _fourierType = value;
                    RaisePropertyChanged("FourierType");
                }
            }
        }

        private ObservableCollection<ImageViewModel> _images;
        public ObservableCollection<ImageViewModel> Images
        {
            get { return _images ?? (_images = new ObservableCollection<ImageViewModel>()); }
        }

        private double _filterLimit1 = 0.1;
        public double FilterLimit1
        {
            get { return _filterLimit1; }
            set
            {
                if (value > FilterLimit2)
                    value = FilterLimit2;
                if (_filterLimit1 != value)
                {
                    _filterLimit1 = value;
                    RaisePropertyChanged("FilterLimit1");
                }
            }
        }

        private double _filterLimit2 = 0.4;
        public double FilterLimit2
        {
            get { return _filterLimit2; }
            set
            {
                if (value < FilterLimit1)
                    value = FilterLimit1;
                if (_filterLimit2 != value)
                {
                    _filterLimit2 = value;
                    RaisePropertyChanged("FilterLimit2");
                }
            }
        }

        private bool _filterIsFromCenter = false;
        public bool FilterIsFromCenter
        {
            get { return _filterIsFromCenter; }
            set
            {
                if (_filterIsFromCenter != value)
                {
                    _filterIsFromCenter = value;
                    RaisePropertyChanged("FilterIsFromCenter");
                }
            }
        }

        private FilterType _filterType = FilterType.Corner;
        public FilterType FilterType
        {
            get { return _filterType; }
            set
            {
                if (_filterType != value)
                {
                    _filterType = value;
                    RaisePropertyChanged("FilterType");
                }
            }
        }

        #endregion // process image

        #region IProgress Members

        private string _taskCaption;
        public string TaskCaption
        {
            get { return _taskCaption; }
            set
            {
                if (_taskCaption != value)
                {
                    _taskCaption = value;
                    RaisePropertyChanged("TaskCaption");
                }
            }
        }

        private int _progress;
        public int Progress
        {
            get { return _progress; }
            set
            {
                if (_progress != value)
                {
                    _progress = value;
                    RaisePropertyChanged("Progress");
                }
            }
        }

        #endregion
    }
}
