using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace LZW
{
    public abstract class LzwTabulka
    {
        protected int pocetByte;
        protected List<string> tabulka;

        protected LzwTabulka(int pocetByte)
        {
            this.pocetByte = pocetByte;
        }

        protected void PridejDoTabulky(string zaznam)
        {
            tabulka.Add(zaznam);
        }

        protected int DejKodTabulky(string zaznam)
        {
            return tabulka.IndexOf(zaznam);
        }

        protected string DejZaznamTabulky(int kod)
        {
            if ((kod >= 0) && (kod < tabulka.Count))
                return tabulka[kod];
            return string.Empty;
        }

        public void NovaTabulka()
        {
            tabulka = new List<string>();
            if (pocetByte > 1)
            {
                for (int idx = 0; idx < 256; idx++)
                {
                    string text = Char.ConvertFromUtf32(idx);
                    tabulka.Add(text);
                }
            }
            else
            {
                for (int idx = 0; idx < 128; idx++)
                {
                    string text = Char.ConvertFromUtf32(idx);
                    if ((Char.IsLetter(text, 0)) || (Char.IsPunctuation(text, 0)) ||
                        (Char.IsSymbol(text, 0)) || (Char.IsWhiteSpace(text, 0)))
                        tabulka.Add(text);
                }
            }
        }
    }

    class LzwKomprese : LzwTabulka
    {
        public LzwKomprese(int pocetByte)
            : base(pocetByte) { }

        private void PridejKod(List<byte> vystup, int kod)
        {
            vystup.Add((byte)(kod & 0xff));
            if (pocetByte > 1)
                vystup.Add((byte)((kod / 256) & 0xff));
        }

        private string DejZnak(string text, ref int idx)
        {
            string znak = char.ConvertFromUtf32(0);
            if ((idx >= 0) && (idx < text.Length))
            {
                znak = text.Substring(idx, 1);
                idx++;
            }
            return znak;
        }

        private int DejKod(List<byte> vstup, ref int idx)
        {
            int kod = 0;
            if ((idx >= 0) && (idx < vstup.Count))
            {
                kod = vstup[idx];
                idx++;
                if (pocetByte > 1)
                {
                    kod += 256 * vstup[idx];
                    idx++;
                }
            }
            return kod;
        }

        public byte[] Komprimuj(string text)
        {
            List<byte> vystup = new List<byte>();
            NovaTabulka();

            int idx = 0;
            string zaznam = DejZnak(text, ref idx);

            while (idx < text.Length)
            {
                string dalsiZnak = DejZnak(text, ref idx);
                string dalsiZaznam = zaznam + dalsiZnak;

                if (tabulka.Contains(dalsiZaznam))
                {
                    zaznam = dalsiZaznam;
                }
                else
                {
                    PridejKod(vystup, DejKodTabulky(zaznam));
                    PridejDoTabulky(dalsiZaznam);
                    zaznam = dalsiZnak.ToString();
                }
            }

            PridejKod(vystup, DejKodTabulky(zaznam));

            return vystup.ToArray();
        }

        public string Dekomprimuj(byte[] vstup)
        {
            string text = string.Empty;
            NovaTabulka();
            List<byte> vstupList = new List<byte>(vstup);

            int idx = 0;
            string zaznam = DejZaznamTabulky(DejKod(vstupList, ref idx));

            while (idx < vstupList.Count)
            {
                text += zaznam;

                int dalsiKod = DejKod(vstupList, ref idx);

                string dalsiZaznam = zaznam + zaznam[0];
                if (dalsiKod < tabulka.Count)
                    dalsiZaznam = DejZaznamTabulky(dalsiKod);

                if (!tabulka.Contains(dalsiZaznam))
                    PridejDoTabulky(zaznam + dalsiZaznam[0]);
                zaznam = dalsiZaznam;
            }

            text += zaznam;

            return text;
        }
    }

    class Program
    {
        private static LzwKomprese komprese;

        private static string cesta = "";

        static void Komprimuj(string souborVstup, string souborVystup)
        {
            souborVstup = Path.Combine(cesta, souborVstup);
            souborVystup = Path.Combine(cesta, souborVystup);
            if (File.Exists(souborVstup))
            {
                string vstup = string.Empty;

                TextReader reader = null;
                try
                {
                    // precti soubor do listu radku
                    reader = new StreamReader(souborVstup);
                    vstup = reader.ReadToEnd();
                }
                finally
                {
                    if (reader != null)
                        reader.Close();
                }

                byte[] vystup = komprese.Komprimuj(vstup);

                BinaryWriter writer = null;
                try
                {
                    // precti soubor do listu radku
                    writer = new BinaryWriter(File.Open(souborVystup, FileMode.Create));
                    writer.Write(vystup);

                    Console.WriteLine("Soubor byl zkomprimovan.");
                    double pomer = 100 * (double)vystup.Length / (double)vstup.Length;
                    pomer = Math.Round(pomer, 2);
                    Console.WriteLine("Kompresni pomer: " + pomer + "%");
                }
                finally
                {
                    if (writer != null)
                        writer.Close();
                }
            }
        }

        static void Dekomprimuj(string souborVstup, string souborVystup)
        {
            souborVstup = Path.Combine(cesta, souborVstup);
            souborVystup = Path.Combine(cesta, souborVystup);
            if (File.Exists(souborVstup))
            {
                byte[] vstup = new byte[0];
                BinaryReader reader = null;
                try
                {
                    // precti soubor do listu radku
                    FileStream file = File.Open(souborVstup, FileMode.Open);
                    reader = new BinaryReader(file);
                    vstup = reader.ReadBytes((int)file.Length);
                }
                finally
                {
                    if (reader != null)
                        reader.Close();
                }

                string output = komprese.Dekomprimuj(vstup);

                TextWriter writer = null;
                try
                {
                    // precti soubor do listu radku
                    writer = new StreamWriter(souborVystup);
                    writer.Write(output);

                    Console.WriteLine("Soubor byl obnoven.");
                }
                finally
                {
                    if (writer != null)
                        writer.Close();
                }
            }
        }

        static void Main(string[] args)
        {
            komprese = new LzwKomprese(2);
            Komprimuj("LzwInput.txt", "LzwCompress.txt");
            Dekomprimuj("LzwCompress.txt", "LzwOutput.txt");
            Console.ReadKey();
        }
    }
}
