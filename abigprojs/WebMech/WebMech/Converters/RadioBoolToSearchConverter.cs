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
using WebMech.WebMechService;

namespace WebMech
{
    public class RadioBoolToSearchConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            SearchType searchType = (SearchType)value;
            int radioIndex = int.Parse(parameter.ToString());
            if ((int)searchType == radioIndex)
                return true;
            else
                return false;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            int radioIndex = int.Parse(parameter.ToString());
            return (SearchType)radioIndex;
        }
    }
}
