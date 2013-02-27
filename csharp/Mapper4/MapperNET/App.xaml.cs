using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Windows;
using Mapper.GUI;
using Mapper.Common;
using Mapper.Core;

namespace Mapper
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        #region override protected methods

        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            //Resources.Add("Locator", GetLocator());

            MainWindowView mainWindow = new MainWindowView();

            ProgramData programData = new ProgramData();
            mainWindow.DataContext = new MainWindowViewModel(programData, new CoreManager(programData));

            mainWindow.Show();
        }

        protected override void OnActivated(EventArgs e)
        {
            base.OnActivated(e);

            MainWindow.Activate();
        }

        #endregion // override protected methods

        #region private methods

        private static ViewModelLocator GetLocator()
        {
            return new ViewModelLocator();
        }

        #endregion // private methods
    }
}
