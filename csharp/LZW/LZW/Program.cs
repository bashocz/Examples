using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Basho.LZW
{
    class LzwStringTable
    {
        public LzwStringTable(int numBytesPerCode)
        {
            maxCode = (1 << (8 * numBytesPerCode)) - 1;
        }

        public void AddCode(string s)
        {
            if (nextAvailableCode <= maxCode)
            {
                if (s.Length != 1 && !table.ContainsKey(s))
                    table[s] = nextAvailableCode++;
            }
            else
            {
                throw new Exception("LZW string table overflow");
            }
        }

        public int GetCode(string s)
        {
            if (s.Length == 1)
                return (int)s[0];
            else
                return table[s];
        }

        public bool Contains(string s)
        {
            return s.Length == 1 || table.ContainsKey(s);
        }

        private Dictionary<string, int> table = new Dictionary<string, int>();
        private int nextAvailableCode = 256;
        private int maxCode;
    }

    class Program
    {
        private const string sourceFileName = @"Input.txt";
        private const string outputFileName = @"Compressed.txt";

        private const int NumBytesPerCode = 2;

        static int ReadCode(BinaryReader reader)
        {
            int code = 0;
            int shift = 0;

            for (int i = 0; i < NumBytesPerCode; i++)
            {
                byte nextByte = reader.ReadByte();
                code += nextByte << shift;
                shift += 8;
            }

            return code;
        }

        static void WriteCode(BinaryWriter writer, int code)
        {
            int shift = 0;
            int mask = 0xFF;

            for (int i = 0; i < NumBytesPerCode; i++)
            {
                byte nextByte = (byte)((code >> shift) & mask);
                writer.Write(nextByte);
                shift += 8;
            }
        }

        static void Compress(StreamReader input, BinaryWriter output)
        {
            LzwStringTable table = new LzwStringTable(NumBytesPerCode);

            char firstChar = (char)input.Read();
            string match = firstChar.ToString();

            while (input.Peek() != -1)
            {
                char nextChar = (char)input.Read();
                string nextMatch = match + nextChar;

                if (table.Contains(nextMatch))
                {
                    match = nextMatch;
                }
                else
                {
                    WriteCode(output, table.GetCode(match));
                    table.AddCode(nextMatch);
                    match = nextChar.ToString();
                }
            }

            WriteCode(output, table.GetCode(match));
        }

        static void Decompress(BinaryReader input, StreamWriter output)
        {
            List<string> table = new List<string>();

            for (int i = 0; i < 256; i++)
            {
                char ch = (char)i;
                table.Add(ch.ToString());
            }

            int firstCode = ReadCode(input);
            char matchChar = (char)firstCode;
            string match = matchChar.ToString();

            output.Write(match);

            while (input.PeekChar() != -1)
            {
                int nextCode = ReadCode(input);

                string nextMatch;
                if (nextCode < table.Count)
                    nextMatch = table[nextCode];
                else
                    nextMatch = match + match[0];

                output.Write(nextMatch);

                table.Add(match + nextMatch[0]);
                match = nextMatch;
            }
        }

        static void TestCompress()
        {
            FileStream inputStream = new FileStream(sourceFileName, FileMode.Open);
            StreamReader inputReader = new StreamReader(inputStream);

            FileStream outputStream = new FileStream(outputFileName, FileMode.Create);
            BinaryWriter outputWriter = new BinaryWriter(outputStream);

            Compress(inputReader, outputWriter);

            outputWriter.Close();
            outputStream.Close();

            inputReader.Close();
            inputStream.Close();
        }

        static void TestDecompres()
        {
            FileStream inputStream = new FileStream("Compressed.txt", FileMode.Open);
            BinaryReader inputReader = new BinaryReader(inputStream);

            FileStream outputStream = new FileStream("Decompressed.txt", FileMode.Create);
            StreamWriter outputWriter = new StreamWriter(outputStream, Encoding.ASCII);

            Decompress(inputReader, outputWriter);

            outputWriter.Close();
            outputStream.Close();

            inputReader.Close();
            inputStream.Close();
        }

        static void Main(string[] args)
        {
            TestCompress();
            TestDecompres();
        }
    }
}