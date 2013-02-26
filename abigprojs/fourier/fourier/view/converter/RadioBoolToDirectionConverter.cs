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
using System.Windows.Data;
using System.Globalization;
using Fourier.Domain;

namespace Fourier
{
    public class RadioBoolToDirectionConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            bool isFromCenter = (bool)value;
            int radioIndex = int.Parse(parameter.ToString());
            if ((isFromCenter && (radioIndex == 0)) ||
                (!isFromCenter && (radioIndex == 1)))
                return true;
            return false;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            int radioIndex = int.Parse(parameter.ToString());
            if (radioIndex == 0)
                return true;
            return false;
        }
    }
}
