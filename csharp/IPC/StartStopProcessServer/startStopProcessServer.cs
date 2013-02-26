using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.IO.Pipes;
using System.IO;
using System.Threading;

namespace StartStopProcessServer
{
    class Program
    {
        static void Main(string[] args)
        {
            ProcessClient pc1 = NewProcess("CLIE01");
            Thread.Sleep(1000);
            ProcessClient pc2 = NewProcess("CLIE02");
            Thread.Sleep(1000);
            CloseProcess(pc1);
            Thread.Sleep(2000);
            ProcessClient pc3 = NewProcess("CLIE03");
            Thread.Sleep(1000);
            CloseProcess(pc3);
            Thread.Sleep(1000);
            CloseProcess(pc2);
            LogIt("Client quit. Server terminating.");
            Console.ReadKey();
        }

        private static ProcessClient NewProcess(string name)
        {
            Process pipeClient = new Process();
            pipeClient.StartInfo.FileName = "StartStopProcessClient.exe";

            NamedPipeServerStream pipeServer = new NamedPipeServerStream(name, PipeDirection.Out);
            pipeClient.StartInfo.Arguments = name;
            pipeClient.StartInfo.UseShellExecute = false;
            pipeClient.Start();

            pipeServer.WaitForConnection();

            StreamWriter sw = new StreamWriter(pipeServer);
            sw.AutoFlush = true;

            ProcessClient pc = new ProcessClient { Process = pipeClient, PipeStream = pipeServer, Sw = sw };
            SendMessage(pc, name);
            return pc;
        }

        private static void CloseProcess(ProcessClient pc)
        {
            SendMessage(pc, "STOP");
            pc.PipeStream.WaitForPipeDrain();
            pc.Process.WaitForExit();

            if (pc.Sw != null)
            {
                pc.Sw.Close();
                pc.Sw.Dispose();
            }
            if (pc.PipeStream != null)
            {
                pc.PipeStream.Close();
                pc.PipeStream.Dispose();
            }

            pc.Process.Close();
        }

        private static void SendMessage(ProcessClient pc, string message)
        {
            pc.Sw.WriteLine(message);
            LogItLine(message);
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

        class ProcessClient
        {
            public Process Process;
            public NamedPipeServerStream PipeStream;
            public StreamWriter Sw;
        }
    }
}
