using System;
using System.Collections.Generic;
using System.Text;

namespace Basho.ThreadApp
{
    public interface IActivity
    {
        void Start();
        void Stop();
        void Reset();
        ActivityState State { get; }
        int Progress { get; }
        event EventHandler ProgressChanged;
    }
}
