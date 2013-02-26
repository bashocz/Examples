using System;
using System.Collections.Generic;
using System.Text;

namespace Mapper.Equipment.Foi
{
    public class TimeItem
    {
        private readonly string activity;
        private DateTime start;
        private DateTime end;

        public TimeItem(string activity)
        {
            this.activity = activity;
        }

        public void Start()
        {
            this.start = DateTime.Now;
        }

        public void Start(DateTime start)
        {
            this.start = start;
        }

        public void End()
        {
            this.end = DateTime.Now;
        }

        public override string ToString()
        {
            return activity + ": " + Duration.ToString();
        }

        public string Activity
        {
            get { return activity; }
        }

        public DateTime StartTime
        {
            get { return start; }
        }

        public DateTime EndTime
        {
            get { return end; }
        }

        public TimeSpan Duration
        {
            get { return end - start; }
        }
    }
}
