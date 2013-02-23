using System;
using System.Collections.Generic;
using System.Text;

namespace Basho.ThreadApp
{
    public enum ActivityState
    {
        Idle = 0,
        Running = 1,
        Finished = 2,
        Cancelled = 3,
        Error = 4
    }
}
