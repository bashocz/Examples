using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.IO.Pipes;
using System.Threading;

namespace IpcClient
{
    class IpcClient
    {
        static void Main(string[] args)
        {
            if (args.Length > 0)
            {
                using (PipeStream pipeClient =
                    new AnonymousPipeClientStream(PipeDirection.In, args[0]))
                {
                    // Show that anonymous Pipes do not support Message mode. 
                    try
                    {
                        LogItLine("Setting ReadMode to \"Message\".");
                        pipeClient.ReadMode = PipeTransmissionMode.Message;
                    }
                    catch (NotSupportedException e)
                    {
                        LogItLine(string.Format("Execption:\n    {0}", e.Message));
                    }

                    LogItLine(string.Format("Current TransmissionMode: {0}.", pipeClient.TransmissionMode));

                    using (StreamReader sr = new StreamReader(pipeClient))
                    {
                        // Display the read text to the console 
                        string temp;

                        // Wait for 'sync message' from the server. 
                        do
                        {
                            LogItLine("Wait for sync...");
                            temp = sr.ReadLine();
                        }
                        while (!temp.StartsWith("SYNC"));

                        // Read the server data and echo to the console. 
                        while ((temp = sr.ReadLine()) != "END")
                        {
                            if (temp != null)
                            {
                                LogItLine("Echo: " + temp);
                                Thread.Sleep(500);
                            }
                            else
                                LogItLine("null");
                        }
                        LogItLine("END...");
                    }
                }
            }
            LogIt("Press Enter to continue...");
            Console.ReadLine();
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
