using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Media;

namespace MvvmGrid.ViewModel
{
    class EllipseViewModel : GridItemViewModel
    {
        public EllipseViewModel(IItemAction actions)
            : base(actions) { }

        private Color color;
        public Color Color
        {
            get { return color; }
            set
            {
                if (color != value)
                {
                    color = value;
                    NotifyPropertyChanged("Color");
                    NotifyPropertyChanged("Stroke");
                }
            }
        }

        public Brush Stroke
        {
            get { return new SolidColorBrush(color); }
        }
    }
}
