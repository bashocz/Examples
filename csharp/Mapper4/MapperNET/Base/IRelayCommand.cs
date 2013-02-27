using System;
using System.Windows.Input;

namespace Mapper.GUI
{
    public interface IRelayCommand : ICommand
    {
        void RaiseCanExecuteChanged();
    }
}
