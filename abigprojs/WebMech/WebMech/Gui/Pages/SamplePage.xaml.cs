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

namespace WebMech
{
	public partial class SamplePage : UserControl
	{
        public SamplePage()
        {
            // Required to initialize variables
            InitializeComponent();
        }

        public void SetDataProvider(DataProvider dataProvider)
        {
            imgSample.DataContext = dataProvider;
        }
    }
}