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
    public class OperationStartedEventArgs : EventArgs
    {
        private readonly string message;

        public OperationStartedEventArgs() { }

        public OperationStartedEventArgs(string message)
        {
            this.message = message;
        }

        public override string ToString()
        {
            return "Message = " + message;
        }

        public string Message
        {
            get { return message; }
        }
    }
}
