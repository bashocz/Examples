using System;
using System.Collections.Generic;
using System.Text;

namespace Ukoly
{
    public class Ukol
    {
        #region private fields

        private DateTime datum;
        private bool dulezity;
        private bool upozorneni;
        private string text;

        #endregion

        #region constructors

        public Ukol()
            : this(DateTime.Now, false, false, string.Empty) { }

        public Ukol(DateTime datum, bool dulezity, bool upozorneni, string text)
        {
            this.datum = datum;
            this.dulezity = dulezity;
            this.upozorneni = upozorneni;
            this.text = text;
        }

        #endregion

        #region private methods

        #endregion

        #region public methods

        #endregion

        #region properties

        public DateTime Datum
        {
            get { return datum; }
            set { datum = value; }
        }

        public bool Dulezity
        {
            get { return dulezity; }
            set { dulezity = value; }
        }

        public bool Upozorneni
        {
            get { return upozorneni; }
            set { upozorneni = value; }
        }

        public string Text
        {
            get { return text; }
            set { text = value; }
        }

        #endregion
    }
}
