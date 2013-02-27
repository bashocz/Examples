using System;
using System.ComponentModel;

namespace Mapper.Core
{
    public interface ICoreManager
    {
        event PropertyChangedEventHandler PropertyChanged;

        ProcessState State { get; }

        void StartProcess();
    }
}
