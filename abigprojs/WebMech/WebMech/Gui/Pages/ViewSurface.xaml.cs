using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using WebMech.WebMechService;

namespace WebMech
{
	public partial class ViewSurface : UserControl
    {
        private DataProvider dataProvider;
        private DeleteDialog dlgDelete;

        public ViewSurface()
		{
			// Required to initialize variables
			InitializeComponent();
        }

        private void UserControl_Loaded(object sender, System.Windows.RoutedEventArgs e)
        {
        }

        private void DataProviderPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if ((Visibility == Visibility.Visible) && (dataProvider.SelectedSurface != null) &&
                (string.Compare(e.PropertyName, "SelectedSurface") == 0))
            {
                dataProvider.GetSampleList();
            }
        }

        private void btnSurfacePrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            dataProvider.SurfaceFilter.Start -= dataProvider.SurfaceFilter.Count;
            dataProvider.GetSurfaceList();
        }

        private void btnSurfaceNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            dataProvider.SurfaceFilter.Start += dataProvider.SurfaceFilter.Count;
            dataProvider.GetSurfaceList();
        }

        private void btnDeleteSurface_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            dlgDelete.Show((sender as Button).DataContext as SurfaceData);
        }

        private void btnSamplePrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            if (lbSurfaces.SelectedItem != null)
            {
                dataProvider.SampleFilter.Start -= dataProvider.SampleFilter.Count;
                dataProvider.GetSampleList();
            }
        }

        private void btnSampleNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            if (lbSurfaces.SelectedItem != null)
            {
                dataProvider.SampleFilter.Start += dataProvider.SampleFilter.Count;
                dataProvider.GetSampleList();
            }
        }

        private void btnDeleteSample_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            dlgDelete.Show((sender as Button).DataContext as SampleData);
        }

        private void btnParShow_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            LayoutRoot.ColumnDefinitions[2].Width = new GridLength(300);
            LayoutRoot.ColumnDefinitions[3].Width = new GridLength(0);
        }

        private void btnParHide_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            LayoutRoot.ColumnDefinitions[2].Width = new GridLength(0);
            LayoutRoot.ColumnDefinitions[3].Width = new GridLength(24);
        }

        public void SetDataProvider(DataProvider dataProvider, DeleteDialog dlgDelete)
        {
            this.dataProvider = dataProvider;
            this.dlgDelete = dlgDelete;
            dataProvider.PropertyChanged += new PropertyChangedEventHandler(DataProviderPropertyChanged);

            lbSurfaces.ItemsSource = dataProvider.SurfaceList;
            gridSurfacePages.DataContext = dataProvider.SurfacePageInfo;

            lbSamples.ItemsSource = dataProvider.SampleList;
            gridSamplePages.DataContext = dataProvider.SamplePageInfo;
            rectDisableSamples.DataContext = dataProvider.Visualization;

            gridVisualization.DataContext = dataProvider.Visualization;

            pageSample.SetDataProvider(dataProvider);
            pageModel3D.SetDataProvider(dataProvider);
            pageSlideshow.SetDataProvider(dataProvider);
            pageHistogram.SetDataProvider(dataProvider);
        }
    }
}