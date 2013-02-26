using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Controls;
using System.Windows;

namespace Fourier.View
{
    class FilterSlider : Slider
    {
        public FilterSlider() : base() { }
        static FilterSlider()
        {
            ValueProperty.OverrideMetadata(typeof(FilterSlider),
                new FrameworkPropertyMetadata(0.0, null, new CoerceValueCallback(NewCoerceValue)));
        }

        public static object NewCoerceValue(DependencyObject d, object value)
        {
            FilterSlider slider = (FilterSlider)d;
            double v = (double)value;
            if (v < slider.MinimumSlider)
                return slider.MinimumSlider;
            if (v > slider.MaximumSlider)
                return slider.MaximumSlider;
            return v;
        }

        #region MinimumSlider

        public double MinimumSlider
        {
            get { return (double)GetValue(MinimumSliderProperty); }
            set { SetValue(MinimumSliderProperty, value); }
        }

        public static readonly DependencyProperty MinimumSliderProperty =
            DependencyProperty.Register("MinimumSlider", typeof(double), typeof(FilterSlider),
            new FrameworkPropertyMetadata(0.0, new PropertyChangedCallback(MinimumSliderChangedCallback)));

        protected static void MinimumSliderChangedCallback(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            FilterSlider slider = (FilterSlider)d;
            //d.CoerceValue(ValueProperty);
        }

        #endregion

        #region MaximumSlider

        public double MaximumSlider
        {
            get { return (double)GetValue(MaximumSliderProperty); }
            set { SetValue(MaximumSliderProperty, value); }
        }

        public static readonly DependencyProperty MaximumSliderProperty =
            DependencyProperty.Register("MaximumSlider", typeof(double), typeof(FilterSlider),
            new PropertyMetadata(1.0, new PropertyChangedCallback(MaximumSliderChangedCallback)));

        protected static void MaximumSliderChangedCallback(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            FilterSlider slider = (FilterSlider)d;
            //d.CoerceValue(ValueProperty);
        }

        #endregion
    }
}
