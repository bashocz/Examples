using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Basho.DottedDieAnalyzer
{
    class ImageInfo
    {
        private readonly string fullFileName;
        private bool isDot;
        private TimeSpan time;

        public ImageInfo(string fileName)
        {
            this.fullFileName = fileName;
        }

        public string FullFileName
        {
            get { return fullFileName; }
        }

        public string FileName
        {
            get { return Path.GetFileName(fullFileName); }
        }

        public bool IsDot
        {
            get { return isDot; }
            set { isDot = value; }
        }

        public TimeSpan Time
        {
            get { return time; }
            set { time = value; }
        }
    }
}
