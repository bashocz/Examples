using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.IO;
using System.IO.Pipes;

namespace StartStopProcessClient
{
    class StartStopProcessClient
    {
        static bool isStopped = false;

        static void Main(string[] args)
        {
            if (args.Length > 0)
            {
                OpenPipeline(args[0]);

                ReadClientName();
                StartReadStopped();

                LogItLine("Process is started.");

                int c = 0;
                while (!isStopped)
                {
                    c++;
                    LogItLine("Counting: " + c.ToString());
                    Thread.Sleep(500);
                }

                ClosePipeline();
            }

            LogItLine("Process is stopping.");
        }

        static NamedPipeClientStream pipeClient;
        static byte[] buffer = new byte[2048];

        private static void OpenPipeline(string pipeHandle)
        {
            pipeClient = new NamedPipeClientStream(".", pipeHandle, PipeDirection.In);
            pipeClient.Connect();
        }

        private static void ClosePipeline()
        {
            if (pipeClient != null)
            {
                pipeClient.Close();
                pipeClient.Dispose();
            }
        }

        private static void ReadClientName()
        {
            endRead = false;
            pipeClient.BeginRead(buffer, 0, buffer.Length, EndReadClientName, null);
            while (!endRead)
                Thread.Sleep(1);
        }

        static bool endRead = false;
        private static void EndReadClientName(IAsyncResult ar)
        {
            int bytesRead = pipeClient.EndRead(ar);
            if (bytesRead > 0)
            {
                clientName = Encoding.ASCII.GetString(buffer, 0, bytesRead - 2);
            }
            buffer.Initialize();
            endRead = true;
        }

        private static void StartReadStopped()
        {
            pipeClient.BeginRead(buffer, 0, buffer.Length, EndReadStopped, null);
        }

        private static void EndReadStopped(IAsyncResult ar)
        {
            int bytesRead = pipeClient.EndRead(ar);
            if (bytesRead > 0)
            {
                string message = Encoding.ASCII.GetString(buffer, 0, bytesRead - 2);
                if (message == "STOP")
                {
                    isStopped = true;
                    return;
                }
            }
            buffer.Initialize();
            StartReadStopped();
        }

        private static void LogItLine(string message)
        {
            Console.WriteLine(FormatMessage(message));
        }

        private static void LogIt(string message)
        {
            Console.Write(FormatMessage(message));
        }

        static string clientName = "CLIENT";
        private static string FormatMessage(string message)
        {
            return "[" + clientName + "] " + message;
        }
    }
}
