using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mapper.Common
{
    public class Lot : NotifiableObject, ILot
    {
        #region constructors

        public Lot(string lotId)
        {
            _lotId = lotId;
        }

        #endregion // constructors

        #region public properties

        private readonly string _lotId;
        public string LotId
        {
            get { return _lotId; }
        }

        private string _waferId;
        public string WaferId
        {
            get { return _waferId; }
            set
            {
                if (string.Compare(_waferId, value) != 0)
                {
                    _waferId = value;
                    RaisePropertyChanged("WaferId");
                }
            }
        }

        private int _lotProgress;
        public int LotProgress
        {
            get { return _lotProgress; }
            set
            {
                if (_lotProgress != value)
                {
                    _lotProgress = value;
                    RaisePropertyChanged("LotProgress");
                }
            }
        }

        private int _waferProgress;
        public int WaferProgress
        {
            get { return _waferProgress; }
            set
            {
                if (_waferProgress != value)
                {
                    _waferProgress = value;
                    RaisePropertyChanged("WaferProgress");
                }
            }
        }

        #endregion // public properties
    }
}
