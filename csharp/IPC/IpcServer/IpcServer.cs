using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.IO;
using System.IO.Pipes;
using System.Threading;

namespace IpcServer
{
    class IpcServer
    {
        static void Main(string[] args)
        {
            Process pipeClient = new Process();

            pipeClient.StartInfo.FileName = "IpcClient.exe";

            using (AnonymousPipeServerStream pipeServer =
                new AnonymousPipeServerStream(PipeDirection.Out,
                HandleInheritability.Inheritable))
            {
                // Show that anonymous pipes do not support Message mode. 
                try
                {
                    LogItLine("Setting ReadMode to \"Message\".");
                    pipeServer.ReadMode = PipeTransmissionMode.Message;
                }
                catch (NotSupportedException e)
                {
                    LogItLine(string.Format("Exception:\n    {0}", e.Message));
                }

                LogItLine(string.Format("Current TransmissionMode: {0}.", pipeServer.TransmissionMode));

                // Pass the client process a handle to the server.
                pipeClient.StartInfo.Arguments =
                    pipeServer.GetClientHandleAsString();
                pipeClient.StartInfo.UseShellExecute = false;
                pipeClient.Start();

                pipeServer.DisposeLocalCopyOfClientHandle();

                try
                {
                    // Read user input and send that to the client process. 
                    using (StreamWriter sw = new StreamWriter(pipeServer))
                    {
                        sw.AutoFlush = true;
                        // Send a 'sync message' and wait for client to receive it.
                        SendMessage(pipeServer, sw, "SYNC");
                        // Send the console input to the client process.
                        for (int i = 0; i < 5; i++)
                        {
                            SendMessage(pipeServer, sw, string.Format("Message {0}", i));
                        }
                        // Send a 'sync message' and wait for client to receive it.
                        SendMessage(pipeServer, sw, "END");
                    }
                }
                // Catch the IOException that is raised if the pipe is broken 
                // or disconnected. 
                catch (IOException e)
                {
                    LogItLine(string.Format("Error: {0}", e.Message));
                }
            }

            pipeClient.WaitForExit();
            pipeClient.Close();
            LogIt("Client quit. Server terminating.");
            Console.ReadKey();
        }

        private static void SendMessage(AnonymousPipeServerStream pipeServer, StreamWriter sw, string message)
        {
            sw.WriteLine(message);
            LogItLine(message);
            pipeServer.WaitForPipeDrain();
            Thread.Sleep(1000);
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
