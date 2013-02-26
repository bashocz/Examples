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
using System.ComponentModel;
using WebMech.WebMechService;

namespace WebMech
{
	public partial class HistogramPage : UserControl
	{
        private class ChartPoint
        {
            private double x, y;

            public ChartPoint(double x, double y)
            {
                this.x = x;
                this.y = y;
            }

            public double X
            {
                get { return x; }
            }

            public double Y
            {
                get { return y; }
            }
        }


        private static readonly DependencyProperty VisibilityChangedWorkaroundProperty = DependencyProperty.Register(
                "VisibilityChangedHistogramPage", typeof(Visibility), typeof(HistogramPage),
                 new PropertyMetadata(VisibilityProperty_Changed));

        private static void VisibilityProperty_Changed(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if ((Visibility)e.NewValue == Visibility.Visible)
            {
                ((HistogramPage)d).NewHistogram();
            }
            else
            {
                ((HistogramPage)d).ClearHistogram();
            }
        }

        private DataProvider dataProvider;

        public HistogramPage()
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
        }

        private void DataProviderPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if ((Visibility == Visibility.Visible) && (string.Compare(e.PropertyName, "SelectedSurface") == 0))
            {
                NewHistogram();
            }
        }

        private void lbParameter_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            if (e.AddedItems.Count == 1)
                DrawHistogram();
        }

        private void NewHistogram()
        {
            if ((dataProvider != null) && (dataProvider.ParameterNameList.Count > 0))
            {
                if (lbParameter.SelectedIndex < 0)
                    lbParameter.SelectedIndex = 0; // -> automaticky draw
                else
                    DrawHistogram();
            }
            else
                ClearHistogram();
        }

        private void DrawHistogram()
        {
            string parameterName = dataProvider.ParameterNameList[lbParameter.SelectedIndex].Name;
            PointCollection points = new PointCollection();
            for (int i = 0; i < dataProvider.SampleList.Count; i++)
            {
                double value = 0;
                foreach (ParameterData parameter in dataProvider.SampleList[i].ParameterList)
                    if (string.Compare(parameter.Name, parameterName) == 0)
                    {
                        value = parameter.Value;
                        break;
                    }
                points.Add(new Point(i + 1, value));
            }
            chartHistogram.DataContext = points;
        }

        private void ClearHistogram()
        {
            chartHistogram.DataContext = null;
        }

        public void SetDataProvider(DataProvider dataProvider)
        {
            this.dataProvider = dataProvider;
            dataProvider.PropertyChanged += new PropertyChangedEventHandler(DataProviderPropertyChanged);

            lbParameter.ItemsSource = dataProvider.ParameterNameList;
        }
    }
}