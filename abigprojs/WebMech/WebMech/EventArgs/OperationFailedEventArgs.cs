using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace WebMech
{
    public class OperationFailedEventArgs : EventArgs
    {
        private readonly string exception;

        public OperationFailedEventArgs() { }

        public OperationFailedEventArgs(string exception)
        {
            this.exception = exception;
        }

        public override string ToString()
        {
            return "Exception = " + exception;
        }

        public string Exception
        {
            get { return exception; }
        }
    }
}
