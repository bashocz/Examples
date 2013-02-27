using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mapper.Common
{
    public class ProgramData : NotifiableObject, IProgramData
    {
        #region constructors

        public ProgramData()
        {
            SetupProgramName();
        }

        #endregion // constructors

        #region override public methods

        public override string ToString()
        {
            return ProgramName + " " + Version;
        }

        #endregion

        #region private methods

        private void SetupProgramName()
        {
            SetupProgramName("Mapper", "4.0.0.0", "1234");
        }

        private void SetupProgramName(string programName, string version, string build)
        {
            ProgramName = programName;
            Version = version;
            Build = build;
        }

        #endregion // private methods

        #region IProgramData Members

        private string _programName;
        public string ProgramName
        {
            get { return _programName; }
            private set
            {
                if (string.Compare(_programName, value) != 0)
                {
                    _programName = value;
                    RaisePropertyChanged("ProgramName");
                }
            }
        }

        private string _version;
        public string Version
        {
            get { return _version; }
            private set
            {
                if (string.Compare(_version, value) != 0)
                {
                    _version = value;
                    RaisePropertyChanged("Version");
                }
            }
        }

        private string _build;
        public string Build
        {
            get { return _build; }
            private set
            {
                if (string.Compare(_build, value) != 0)
                {
                    _build = value;
                    RaisePropertyChanged("Build");
                }
            }
        }

        private ILot _lot;
        public ILot Lot
        {
            get { return _lot; }
            set
            {
                if (_lot != value)
                {
                    _lot = value;
                    RaisePropertyChanged("Lot");
                }
            }
        }

        #endregion // IProgramData Members
    }
}
