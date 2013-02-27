using System;
using System.ComponentModel;

namespace Mapper.Common
{
    public interface ILot : INotifyPropertyChanged
    {
        string LotId { get; }
        string WaferId { get; set; }
        int LotProgress { get; set; }
        int WaferProgress { get; set; }
    }
}
