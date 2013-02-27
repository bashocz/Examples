using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Data;
using System.Globalization;
using System.Windows;

namespace BrickPanel
{
    class BrickVisibleConverter : IMultiValueConverter
    {
        public object Convert(object[] values, Type targetType, object parameter, CultureInfo culture)
        {
            try
            {
                double wallHeight = (double)values[0];
                double brickHeight = (double)values[1];
                int brickIndex = System.Convert.ToInt32(parameter.ToString());
                if ((brickIndex * brickHeight) < wallHeight)
                    return Visibility.Visible;
                return Visibility.Collapsed;
            }
            catch
            {
                return Visibility.Collapsed;
            }
        }

        public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
        {
            throw new NotSupportedException("Cannot convert back");
        }
    }
}
