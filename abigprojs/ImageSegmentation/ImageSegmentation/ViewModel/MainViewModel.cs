using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Command;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Drawing;
using Basho.Graphics.Segmentation;
using ImageSegmentation.Helper;
using Basho.Graphics.Filter;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

namespace ImageSegmentation.ViewModel
{
    /// <summary>
    /// This class contains properties that the main View can data bind to.
    /// <para>
    /// Use the <strong>mvvminpc</strong> snippet to add bindable properties to this ViewModel.
    /// </para>
    /// <para>
    /// You can also use Blend to data bind with the tool's support.
    /// </para>
    /// <para>
    /// See http://www.galasoft.ch/mvvm
    /// </para>
    /// </summary>
    class MainViewModel : ViewModelBase
    {
        /// <summary>
        /// Initializes a new instance of the MainViewModel class.
        /// </summary>
        public MainViewModel()
        {
            ////if (IsInDesignMode)
            ////{
            ////    // Code runs in Blend --> create design time data.
            ////}
            ////else
            ////{
            ////    // Code runs "for real"
            ////}
        }

        private RelayCommand _openImageCommand;
        public RelayCommand OpenImageCommand
        {
            get { return _openImageCommand ?? (_openImageCommand = new RelayCommand(OpenImage, CanOpenImage)); }
        }

        private RelayCommand _gaussianImageCommand;
        public RelayCommand GaussianImageCommand
        {
            get { return _gaussianImageCommand ?? (_gaussianImageCommand = new RelayCommand(GaussianImage, CanGaussianImage)); }
        }

        private RelayCommand _gaussianCppImageCommand;
        public RelayCommand GaussianCppImageCommand
        {
            get { return _gaussianCppImageCommand ?? (_gaussianCppImageCommand = new RelayCommand(GaussianCppImage, CanGaussianCppImage)); }
        }

        private RelayCommand _segmentImageCommand;
        public RelayCommand SegmentImageCommand
        {
            get { return _segmentImageCommand ?? (_segmentImageCommand = new RelayCommand(SegmentImage, CanSegmentImage)); }
        }

        private RelayCommand _segmentCppImageCommand;
        public RelayCommand SegmentCppImageCommand
        {
            get { return _segmentCppImageCommand ?? (_segmentCppImageCommand = new RelayCommand(SegmentCppImage, CanSegmentCppImage)); }
        }

        private void OpenImage()
        {
            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog();
            dlg.Filter = "Image files (*.gif;*.jpg;*.jpe;*.png;*.bmp;*.dib;*.tif;*.wmf;*.ras;*.eps;*.pcx;*psd;*.tga)|*.gif;*.jpg;*.jpe;*.png;*.bmp;*.dib;*.tif;*.wmf;*.ras;*.eps;*.pcx;*psd;*.tga";

            Nullable<bool> result = dlg.ShowDialog();

            if (result == true)
            {
                SegmentedImage = null;
                OriginImage = new ImageViewModel(new Bitmap(dlg.FileName));
            }
        }

        private bool CanOpenImage()
        {
            return !ProcessRunning;
        }

        public void SegmentCppImage()
        {
            Task task = Task.Factory.StartNew(() =>
            {
                App.Current.Dispatcher.Invoke(new Action(() =>
                {
                    ProcessRunning = true;
                }));
                try
                {
                    Bitmap src = OriginImage.Bitmap;
                    BitmapData srcData = src.LockBits(new Rectangle(0, 0, src.Width, src.Height), ImageLockMode.ReadOnly, src.PixelFormat);
                    int bytesPerPixel = 1;
                    if (src.PixelFormat == PixelFormat.Format8bppIndexed)
                        bytesPerPixel = 1;
                    else if (src.PixelFormat == PixelFormat.Format24bppRgb)
                        bytesPerPixel = 3;
                    else if ((src.PixelFormat == PixelFormat.Format32bppRgb) || (src.PixelFormat == PixelFormat.Format32bppArgb))
                        bytesPerPixel = 4;

                    Bitmap dst = new Bitmap(src.Width, src.Height, src.PixelFormat);
                    BitmapData dstData = dst.LockBits(new Rectangle(0, 0, dst.Width, dst.Height), ImageLockMode.WriteOnly, dst.PixelFormat);

                    Fhs.Fhs fhs = new Fhs.Fhs();
                    unsafe { fhs.fhs((byte*)srcData.Scan0, src.Width, src.Height, srcData.Stride, bytesPerPixel, (byte*)dstData.Scan0, 0.8, 300); }

                    src.UnlockBits(srcData);
                    dst.UnlockBits(dstData);

                    int[,] segments = ImageHelper.GetSegments(dst);

                    App.Current.Dispatcher.Invoke(new Action(() =>
                    {
                        SegmentedImage = new ImageViewModel(ImageHelper.GetBitmap(segments));
                    }));
                }
                catch { }
                finally
                {
                    App.Current.Dispatcher.Invoke(new Action(() =>
                    {
                        ProcessRunning = false;
                    }));
                }
            });
        }

        public bool CanSegmentCppImage()
        {
            return !ProcessRunning;
        }

        public void SegmentImage()
        {
            Task task = Task.Factory.StartNew(() =>
            {
                App.Current.Dispatcher.Invoke(new Action(() =>
                {
                    ProcessRunning = true;
                }));
                try
                {
                    IFhSegmentation segmentation = SegmentationFactory.Instance.GetFhSegmentation();
                    byte[,] pixels = ImageHelper.GetPixels(OriginImage.Bitmap);
                    if (pixels != null)
                    {
                        GaussianFilter filter = new GaussianFilter();
                        filter.Filter(OriginImage.Bitmap.Width, OriginImage.Bitmap.Height, pixels, 0.8);
                        int[,] segments = segmentation.BuildSegments(OriginImage.Bitmap.Width, OriginImage.Bitmap.Height, pixels, 300);
                        App.Current.Dispatcher.Invoke(new Action(() =>
                        {
                            SegmentedImage = new ImageViewModel(ImageHelper.GetBitmap(segments));
                        }));
                    }
                }
                catch { }
                finally
                {
                    App.Current.Dispatcher.Invoke(new Action(() =>
                    {
                        ProcessRunning = false;
                    }));
                }
            });
        }

        public bool CanSegmentImage()
        {
            return !ProcessRunning;
        }

        public void GaussianCppImage()
        {
            Task task = Task.Factory.StartNew(() =>
            {
                App.Current.Dispatcher.Invoke(new Action(() =>
                {
                    ProcessRunning = true;
                }));
                try
                {
                    Bitmap src = OriginImage.Bitmap;
                    BitmapData srcData = src.LockBits(new Rectangle(0, 0, src.Width, src.Height), ImageLockMode.ReadOnly, src.PixelFormat);
                    int bytesPerPixel = 1;
                    if (src.PixelFormat == PixelFormat.Format8bppIndexed)
                        bytesPerPixel = 1;
                    else if (src.PixelFormat == PixelFormat.Format24bppRgb)
                        bytesPerPixel = 3;
                    else if ((src.PixelFormat == PixelFormat.Format32bppRgb) || (src.PixelFormat == PixelFormat.Format32bppArgb))
                        bytesPerPixel = 4;

                    Bitmap dst = new Bitmap(src.Width, src.Height, src.PixelFormat);
                    BitmapData dstData = dst.LockBits(new Rectangle(0, 0, dst.Width, dst.Height), ImageLockMode.WriteOnly, dst.PixelFormat);

                    Fhs.Fhs fhs = new Fhs.Fhs();
                    unsafe { fhs.gaussian((byte*)srcData.Scan0, src.Width, src.Height, srcData.Stride, bytesPerPixel, (byte*)dstData.Scan0, 0.8); }

                    src.UnlockBits(srcData);
                    dst.UnlockBits(dstData);

                    App.Current.Dispatcher.Invoke(new Action(() =>
                    {
                        SegmentedImage = new ImageViewModel(dst);
                    }));
                }
                catch { }
                finally
                {
                    App.Current.Dispatcher.Invoke(new Action(() =>
                    {
                        ProcessRunning = false;
                    }));
                }
            });
        }

        public bool CanGaussianCppImage()
        {
            return !ProcessRunning;
        }

        public void GaussianImage()
        {
            Task task = Task.Factory.StartNew(() =>
            {
                App.Current.Dispatcher.Invoke(new Action(() =>
                {
                    ProcessRunning = true;
                }));
                try
                {
                    GaussianFilter filter = new GaussianFilter();
                    byte[,] pixels = ImageHelper.GetPixels(OriginImage.Bitmap);
                    if (pixels != null)
                    {
                        filter.Filter(OriginImage.Bitmap.Width, OriginImage.Bitmap.Height, pixels, 0.8);
                        App.Current.Dispatcher.Invoke(new Action(() =>
                        {
                            SegmentedImage = new ImageViewModel(ImageHelper.GetFilterBitmap(pixels));
                        }));
                    }
                }
                catch { }
                finally
                {
                    App.Current.Dispatcher.Invoke(new Action(() =>
                    {
                        ProcessRunning = false;
                    }));
                }
            });
        }

        private bool CanGaussianImage()
        {
            return !ProcessRunning;
        }

        private List<RelayCommand> _commands;
        private IList<RelayCommand> Commands
        {
            get
            {
                if (_commands == null)
                {
                    _commands = new List<RelayCommand>();
                    _commands.Add(OpenImageCommand);
                    _commands.Add(SegmentCppImageCommand);
                    _commands.Add(GaussianCppImageCommand);
                    _commands.Add(SegmentImageCommand);
                    _commands.Add(GaussianImageCommand);
                }
                return _commands.AsReadOnly();
            }
        }

        private void RaiseCanCommands()
        {
            foreach (RelayCommand command in Commands)
                command.RaiseCanExecuteChanged();
        }

        private bool _processRunning;
        private bool ProcessRunning
        {
            get { return _processRunning; }
            set
            {
                if (value != _processRunning)
                {
                    _processRunning = value;
                    RaiseCanCommands();
                }
            }
        }

        private ImageViewModel _originImage;
        public ImageViewModel OriginImage
        {
            get { return _originImage; }
            set
            {
                if (value != _originImage)
                {
                    _originImage = value;
                    RaisePropertyChanged("OriginImage");
                }
            }
        }

        private ImageViewModel _segmentedImage;
        public ImageViewModel SegmentedImage
        {
            get { return _segmentedImage; }
            set
            {
                if (value != _segmentedImage)
                {
                    _segmentedImage = value;
                    RaisePropertyChanged("SegmentedImage");
                }
            }
        }
    }
}