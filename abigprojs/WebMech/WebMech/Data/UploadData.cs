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
using System.IO;
using System.Collections.ObjectModel;
using WebMech.WebMechService;

namespace WebMech
{
    public class UploadData : INotifyPropertyChanged
    {
        private ObservableCollection<SurfaceData> surfaces;
        private FileInfo image;
        private FileInfo points;

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }

        public ObservableCollection<SurfaceData> Surfaces
        {
            get { return surfaces; }
            set
            {
                surfaces = value;
                NotifyPropertyChanged("Surfaces");
            }
        }

        public FileInfo Image
        {
            get { return image; }
            set
            {
                image = value;
                NotifyPropertyChanged("Image");
                NotifyPropertyChanged("UploadEnabled");
            }
        }

        public FileInfo Points
        {
            get { return points; }
            set
            {
                points = value;
                NotifyPropertyChanged("Points");
                NotifyPropertyChanged("UploadEnabled");
            }
        }

        public bool UploadEnabled
        {
            get { return (image != null) && (points != null); }
        }
    }
}
