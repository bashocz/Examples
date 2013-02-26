using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Input;
using System.Diagnostics;
using System.Windows;
using System.Threading;

namespace Fourier
{
    public class RelayCommand : IRelayCommand
    {
        #region private fields

        private readonly Action<object> _execute;
        private readonly Predicate<object> _canExecute;

        private event EventHandler _canExecuteChanged;

        #endregion // private fields

        #region constructors

        public RelayCommand(Action<object> execute)
            : this(execute, null)
        {
        }

        public RelayCommand(Action<object> execute, Predicate<object> canExecute)
        {
            if (execute == null)
                throw new ArgumentNullException("execute");

            _execute = execute;
            _canExecute = canExecute;
        }
        #endregion // constructors

        #region ICommand Members

        public event EventHandler CanExecuteChanged
        {
            add
            {
                CommandManager.RequerySuggested += value;
                _canExecuteChanged += value;
            }
            remove
            {
                CommandManager.RequerySuggested -= value;
                _canExecuteChanged -= value;
            }
        }

        [DebuggerStepThrough]
        public bool CanExecute(object parameter)
        {
            return _canExecute == null ? true : _canExecute(parameter);
        }

        public void Execute(object parameter)
        {
            _execute(parameter);
        }

        #endregion // ICommand Members

        #region IRelayCommand Members

        public void RaiseCanExecuteChanged()
        {
            EventHandler canExecuteChanged = _canExecuteChanged;
            if (canExecuteChanged != null)
            {
                if (!Application.Current.Dispatcher.Thread.Equals(Thread.CurrentThread))
                    Application.Current.Dispatcher.BeginInvoke(canExecuteChanged, this, EventArgs.Empty);
                else
                    canExecuteChanged(this, EventArgs.Empty);
            }
        }

        #endregion // IRelayCommand Members
    }
}
