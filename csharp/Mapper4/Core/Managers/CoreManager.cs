using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mapper.Common;
using System.Threading;

namespace Mapper.Core
{
    public class CoreManager : NotifiableObject, ICoreManager
    {
        #region private fields

        private readonly IProgramData _programData;

        #endregion

        #region constructors

        public CoreManager(IProgramData programData)
        {
            _programData = programData;
        }

        #endregion // constructors

        #region ICoreManager Members

        private ProcessState _state;
        public ProcessState State 
        {
            get { return _state; }
            private set
            {
                if (_state != value)
                {
                    _state = value;
                    RaisePropertyChanged("State");
                }
            }
        }

        public void StartProcess()
        {
            State = ProcessState.Running;

            _programData.Lot.LotProgress = 0;
            for (int w = 0; w < 5; w++)
            {
                _programData.Lot.WaferProgress = 0;
                _programData.Lot.WaferId = (w + 1).ToString();
                for (int d = 0; d < 100; d++)
                {
                    Thread.Sleep(20);
                    _programData.Lot.WaferProgress = d;
                }
                _programData.Lot.WaferProgress = 100;
                _programData.Lot.WaferId = "";
                Thread.Sleep(100);
                _programData.Lot.LotProgress = 20 * (w + 1);
            }
            _programData.Lot.LotProgress = 100;

            State = ProcessState.Idle;
        }

        #endregion // ICoreManager Members
    }
}
