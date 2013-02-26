using System;
using System.Windows.Input;

namespace Fourier
{
    public interface IRelayCommand : ICommand
    {
        void RaiseCanExecuteChanged();
    }
}
