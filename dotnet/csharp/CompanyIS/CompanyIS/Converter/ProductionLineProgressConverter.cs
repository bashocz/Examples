using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Data;
using System.Globalization;

namespace Basho
{
    class ProductionLineProgressConverter : IMultiValueConverter
    {
        public object Convert(
         object[] values, Type targetType,
         object parameter, CultureInfo culture)
        {
            try
            {
                DateTime startDate = (DateTime)values[0];
                DateTime endDate;
                try
                {
                    endDate = (DateTime)values[1];
                }
                catch
                {
                    endDate = DateTime.Now;
                }
                double timeConsuming = (double)values[2];
                return 100 * (endDate - startDate).TotalHours / (timeConsuming / 100);
            }
            catch
            {
                return 0.0;
            }
        }

        public object[] ConvertBack(
         object value, Type[] targetTypes,
         object parameter, CultureInfo culture)
        {
            throw new NotSupportedException("Cannot convert back");
        }
    }
}
