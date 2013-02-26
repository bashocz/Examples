using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace ProcessClient
{
    class ProcessClient
    {
        static bool isStopped = false;

        static void Main(string[] args)
        {
            AppDomain.CurrentDomain.ProcessExit += new EventHandler(CurrentDomain_ProcessExit);

            LogItLine("Process is started.");

            int c = 0;
            while (!isStopped)
            {
                c++;
                LogItLine("Counting: " + c.ToString());
                Thread.Sleep(500);
            }

            LogItLine("Process is stopping.");
            LogIt("Press Enter to continue...");
            Console.ReadLine();
        }

        static void CurrentDomain_ProcessExit(object sender, EventArgs e)
        {
            isStopped = true;
        }

        private static void LogItLine(string message)
        {
            Console.WriteLine(FormatMessage(message));
        }

        private static void LogIt(string message)
        {
            Console.Write(FormatMessage(message));
        }

        private static string FormatMessage(string message)
        {
            return "[CLIENT] " + message;
        }
    }
}
