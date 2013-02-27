using System;
using System.ComponentModel;

namespace Mapper.Common
{
    public interface IProgramData : INotifyPropertyChanged
    {
        string Build { get; }
        string ProgramName { get; }
        string Version { get; }

        ILot Lot { get; set; }
    }
}
