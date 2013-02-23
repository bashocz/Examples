using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;
using System.Diagnostics;

namespace Basho.MemoryOperationMeter
{
    class Program
    {
        static ushort[] Memory = new ushort[2048];

        static void Main(string[] args)
        {
            Stopwatch sw = new Stopwatch();

            Process myProcess = System.Diagnostics.Process.GetCurrentProcess();

            //long from1 = GC.GetTotalMemory(true);
            long from1 = myProcess.PrivateMemorySize64;
            sw.Start();
            for (int idx = 0; idx < 100000; idx++)
                WriteMemory(0, "0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF");
            GC.Collect(0);
            sw.Stop();
            //long to1 = GC.GetTotalMemory(true);
            long to1 = myProcess.PrivateMemorySize64;
            Console.WriteLine(string.Format("Old WriteMemory elapsed time: {0}, used memory: {1}", sw.ElapsedMilliseconds, to1 - from1));

            //long from2 = GC.GetTotalMemory(true);
            long from2 = myProcess.PrivateMemorySize64;
            sw.Reset();
            sw.Start();
            for (int idx = 0; idx < 100000; idx++)
                WriteMemory2(0, "0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF");
            GC.Collect(0);
            sw.Stop();
            //long to2 = GC.GetTotalMemory(true);
            long to2 = myProcess.PrivateMemorySize64;
            Console.WriteLine(string.Format("New WriteMemory elapsed time: {0}, used memory: {1}", sw.ElapsedMilliseconds, to2 - from2));

            //long from3 = GC.GetTotalMemory(true);
            long from3 = myProcess.PrivateMemorySize64;
            sw.Reset();
            sw.Start();
            for (int idx = 0; idx < 100000; idx++)
                ReadMemory(0, 64);
            GC.Collect(0);
            sw.Stop();
            //long to3 = GC.GetTotalMemory(true);
            long to3 = myProcess.PrivateMemorySize64;
            Console.WriteLine(string.Format("Old ReadMemory elapsed time: {0}, used memory: {1}", sw.ElapsedMilliseconds, to3 - from3));

            //long from4 = GC.GetTotalMemory(true);
            long from4 = myProcess.PrivateMemorySize64;
            sw.Reset();
            sw.Start();
            for (int idx = 0; idx < 100000; idx++)
                ReadMemory2(0, 64);
            GC.Collect(0);
            sw.Stop();
            //long to4 = GC.GetTotalMemory(true);
            long to4 = myProcess.PrivateMemorySize64;
            Console.WriteLine(string.Format("New ReadMemory elapsed time: {0}, used memory: {1}", sw.ElapsedMilliseconds, to4 - from4));

            Console.ReadKey();
        }

        static private void WriteMemory(int address, string data)
        {
            while (data.Length > 0)
            {
                //data = data.PadLeft(4, '0'); // necessary ?
                Memory[address++] = BitConverter.ToUInt16(new byte[2] { Convert.ToByte(data.Substring(2, 2), 16),
                                                                        Convert.ToByte(data.Substring(0, 2), 16) }, 0);
                data = data.Remove(0, 4);
            }
        }

        static private string ReadMemory(int address, int length)
        {
            byte[] bytes = new byte[length * sizeof(ushort)];
            Buffer.BlockCopy(Memory, address * sizeof(ushort), bytes, 0, length * sizeof(ushort));

            string result = string.Empty;
            for (int idx = 0; idx < length; idx++)
            {
                result += BitConverter.ToUInt16(bytes, 0 + idx * 2).ToString("X4", CultureInfo.InvariantCulture);
                //result += Convert.ToInt32(BitConverter.ToChar(Memory, 0 + idx * 2)).ToString("X4", CultureInfo.InvariantCulture);
            }
            return result;
        }

        static private void WriteMemory2(int address, string data)
        {
            int idx = 0;
            while (idx < data.Length)
            {
                Memory[address + idx] = Convert.ToUInt16(data.Substring(idx + 2, 2) + data.Substring(idx, 2), 16);
                idx += 4;
            }
        }

        static private string ReadMemory2(int address, int length)
        {
            string result = string.Empty;
            for (int idx = 0; idx < length; idx++)
            {
                result += (((Memory[address + idx] % 256) * 256) + (Memory[address + idx] / 256)).ToString("X4", CultureInfo.InvariantCulture);
            }
            return result;


        }

    }
}
