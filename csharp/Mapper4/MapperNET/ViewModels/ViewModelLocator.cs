using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mapper.Common;
using Mapper.Core;

namespace Mapper.GUI
{
    public class ViewModelLocator
    {
        #region private fields

        private readonly IProgramData _programData;
        private readonly ICoreManager _coreManager;

        private MainWindowViewModel _mainWindow;

        #endregion // private fields

        #region construtors

        public ViewModelLocator()
        {
            _programData = new ProgramData();
            _coreManager = new CoreManager(_programData);

            _mainWindow = new MainWindowViewModel(_programData, _coreManager);
        }

        #endregion // constructors

        #region public properties

        public MainWindowViewModel MainWindow
        {
            get { return _mainWindow; }
        }

        //public MainWindowViewModel MainWindowNew
        //{
        //    get { return new MainWindowViewModel(_programData); }
        //}

        #endregion // public properties
    }
}
