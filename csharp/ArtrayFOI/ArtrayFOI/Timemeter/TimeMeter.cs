using System;
using System.Collections.Generic;
using System.Text;

namespace Mapper.Equipment.Foi
{
    public class TimeMeter : List<TimeItem>
    {
        public void Start(string activity)
        {
            TimeItem item = new TimeItem(activity);
            if (Count > 0)
            {
                Finish();
                item.Start(this[Count - 1].EndTime);
            }
            else
                item.Start();
            Add(item);
        }

        public void Finish()
        {
            if (Count > 0)
                this[Count - 1].End();
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();
            foreach (TimeItem item in this)
                sb.AppendLine(item.ToString());
            sb.AppendLine();
            sb.AppendLine("Process time: " + Duration.ToString());
            return sb.ToString();
        }

        public TimeSpan Duration
        {
            get
            {
                if (Count > 0)
                    return this[Count - 1].EndTime - this[0].StartTime;
                return new TimeSpan();
            }
        }
    }
}
