using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace Basho
{
    public class RecordInfo : INotifyPropertyChanged
    {
        private int start;
        private int count;
        private int total;

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }

        public int Start
        {
            get { return start; }
            set
            {
                if (value != start)
                {
                    start = value;
                    NotifyPropertyChanged("Start");
                    NotifyPropertyChanged("End");
                    NotifyPropertyChanged("IsPrev");
                    NotifyPropertyChanged("IsNext");
                }
            }
        }

        public int End
        {
            get { return Math.Min(start + count - 1, total); }
        }

        public int Count
        {
            get { return count; }
            set
            {
                if (value != count)
                {
                    count = value;
                    NotifyPropertyChanged("Count");
                    NotifyPropertyChanged("End");
                    NotifyPropertyChanged("IsPrev");
                    NotifyPropertyChanged("IsNext");
                }
            }
        }

        public int Total
        {
            get { return total; }
            set
            {
                if (value != total)
                {
                    total = value;
                    NotifyPropertyChanged("Total");
                    NotifyPropertyChanged("End");
                    NotifyPropertyChanged("IsPrev");
                    NotifyPropertyChanged("IsNext");
                }
            }
        }

        public bool IsPrev
        {
            get { return start > count; }
        }

        public bool IsNext
        {
            get { return (start + count) <= total; }
        }
    }
}
