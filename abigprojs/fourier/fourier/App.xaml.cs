using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Windows;
using Fourier.View;
using Fourier.ViewModel;
using System.Windows.Threading;

namespace Fourier
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            MainWindow window = new MainWindow();
            window.DataContext = new MainWindowViewModel(Dispatcher.CurrentDispatcher);
            window.Show();

            base.OnStartup(e);
        }
    }
}
