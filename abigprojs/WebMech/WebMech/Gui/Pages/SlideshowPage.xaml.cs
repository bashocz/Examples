using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Windows.Data;
using System.Windows.Threading;
using System.ComponentModel;

namespace WebMech
{
	public partial class SlideshowPage : UserControl
	{
        private static readonly DependencyProperty VisibilityChangedWorkaroundProperty = DependencyProperty.Register(
                "VisibilityChangedSlideshowPage", typeof(Visibility), typeof(SlideshowPage),
                 new PropertyMetadata(VisibilityProperty_Changed));

        private static void VisibilityProperty_Changed(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if ((Visibility)e.NewValue == Visibility.Visible)
            {
                ((SlideshowPage)d).EnableTimer();
            }
            else
            {
                ((SlideshowPage)d).DisableTimer();
            }
        }

        private DataProvider dataProvider;

        private DispatcherTimer timer;
        private int sampleIndex;

        public SlideshowPage()
        {
            // Required to initialize variables
            InitializeComponent();
        }

        private void UserControl_Loaded(object sender, System.Windows.RoutedEventArgs e)
        {
            Binding visibilityBnd = new Binding("Visibility");
            visibilityBnd.Source = this;
            visibilityBnd.Mode = BindingMode.TwoWay;
            this.SetBinding(VisibilityChangedWorkaroundProperty, visibilityBnd);

            timer = new DispatcherTimer();
            timer.Interval = new TimeSpan(0, 0, 1);
            timer.Stop();
            timer.Tick += new EventHandler(TimerElapsed);
        }

        private void DataProviderPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if ((Visibility == Visibility.Visible) && (string.Compare(e.PropertyName, "SelectedSurface") == 0))
            {
                EnableTimer();
            }
        }

        private void SetSample()
        {
            if (dataProvider != null)
            {
                if (sampleIndex < 0)
                    dataProvider.SelectedSample = null;
                else
                    dataProvider.SelectedSample = dataProvider.SampleList[sampleIndex];
            }
        }

        private void EnableTimer()
        {
            if (dataProvider.SampleList.Count == 0)
            {
                DisableTimer();
            }
            else
            {
                sampleIndex = 0;
                SetSample();

                if ((dataProvider.SampleList.Count > 1) && (timer != null))
                    timer.Start();
                else if (timer != null)
                    timer.Stop();
            }
        }

        private void DisableTimer()
        {
            sampleIndex = -1;
            SetSample();
            if (timer != null)
                timer.Stop();
        }

        private void TimerElapsed(object sender, EventArgs e)
        {
            sampleIndex++;
            if (sampleIndex >= dataProvider.SampleList.Count)
                sampleIndex = 0;
            SetSample();
        }

        public void SetDataProvider(DataProvider dataProvider)
        {
            this.dataProvider = dataProvider;
            dataProvider.PropertyChanged += new PropertyChangedEventHandler(DataProviderPropertyChanged);
            imgSample.DataContext = dataProvider;
            tbSampleIndex.DataContext = dataProvider;
            tbSampleCount.DataContext = dataProvider;
        }
    }
}