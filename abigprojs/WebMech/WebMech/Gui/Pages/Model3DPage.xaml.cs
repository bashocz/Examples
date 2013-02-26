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
using Kit3D.Windows.Media.Media3D;
using Kit3D.Windows.Controls;
using WebMech.WebMechService;
using System.ComponentModel;

namespace WebMech
{
	public partial class Model3DPage : UserControl
	{
        private static readonly DependencyProperty VisibilityChangedWorkaroundProperty = DependencyProperty.Register(
                "VisibilityChangedModel3DPage", typeof(Visibility), typeof(Model3DPage),
                 new PropertyMetadata(VisibilityProperty_Changed));

        private static void VisibilityProperty_Changed(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if ((Visibility)e.NewValue == Visibility.Visible)
            {
                if (((Model3DPage)d).dataProvider != null)
                    ((Model3DPage)d).dataProvider.GetSample();
            }
            else
            {
                if (((Model3DPage)d).visualize != null)
                    ((Model3DPage)d).visualize.Clear();
            }
        }

        private DataProvider dataProvider;

        private Viewport3D mainViewport;

        private VisualizeSurface visualize;

        public Model3DPage()
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

            mainViewport = new Viewport3D();
            mainViewport.ShowModelBoundingBoxes = false;
            viewport.Children.Add(mainViewport);

            visualize = new VisualizeSurface(mainViewport, 100);
        }

        private void DataProviderPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if ((Visibility == Visibility.Visible) && (string.Compare(e.PropertyName, "SelectedSample") == 0))
            {
                if (dataProvider.SelectedSample != null)
                    dataProvider.GetSample();
                else
                    visualize.Clear();
            }
        }

        private void btnSurfaceUp_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            visualize.MoveCamera(10, 0);
        }

        private void btnSurfaceLeft_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            visualize.MoveCamera(0, 10);
        }

        private void btnSurfaceRight_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            visualize.MoveCamera(0, -10);
        }

        private void btnSurfaceDown_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            visualize.MoveCamera(-10, 0);
        }

        public void SetDataProvider(DataProvider dataProvider)
        {
            this.dataProvider = dataProvider;
            dataProvider.Visualize = visualize;
            dataProvider.PropertyChanged += new PropertyChangedEventHandler(DataProviderPropertyChanged);
        }
    }
}