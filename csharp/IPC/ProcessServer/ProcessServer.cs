using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.Threading;

namespace ProcessServer
{
    class ProcessServer
    {
        static void Main(string[] args)
        {
            Process processClient = new Process();

            processClient.StartInfo.FileName = "ProcessClient.exe";
            processClient.StartInfo.UseShellExecute = true; // musts be true
            processClient.Start();

            Thread.Sleep(2000);
            processClient.CloseMainWindow();

            processClient.WaitForExit();
            processClient.Close();
            LogIt("Client quit. Server terminating.");
            Console.ReadKey();
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
            return "[SERVER] " + message;
        }
    }
}
