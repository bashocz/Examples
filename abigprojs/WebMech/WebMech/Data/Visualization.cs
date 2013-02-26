using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.ComponentModel;

namespace WebMech
{
    public class Visualization : INotifyPropertyChanged
    {
        private VisualizationType visualizationType;

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }

        public VisualizationType VisualizationType
        {
            get { return visualizationType; }
            set
            {
                if (!visualizationType.Equals(value))
                {
                    visualizationType = value;
                    NotifyPropertyChanged("VisualizationType");
                }
            }
        }
    }
}
