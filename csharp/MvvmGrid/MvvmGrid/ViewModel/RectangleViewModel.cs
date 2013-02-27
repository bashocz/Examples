using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Media;

namespace MvvmGrid.ViewModel
{
    class RectangleViewModel : GridItemViewModel
    {
        public RectangleViewModel(IItemAction actions)
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
                    NotifyPropertyChanged("BackgroundColor");
                }
            }
        }

        public Brush BackgroundColor
        {
            get { return new SolidColorBrush(color); }
        }
    }
}
