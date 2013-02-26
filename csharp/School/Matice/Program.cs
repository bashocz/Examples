using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Matice
{
    class Matice
    {
        private readonly string name;
        private readonly int width;
        private readonly int height;

        public Matice(string name, int height, int width)
        {
            this.name = name;
            this.width = width;
            this.height = height;
        }

        public string Name
        {
            get { return name; }
        }

        public int Width
        {
            get { return width; }
        }

        public int Height
        {
            get { return height; }
        }
    }

    class Program
    {
        static private int NejminKolikrat(List<Matice> matice)
        {
            if (matice.Count == 1)
                return 0;
            if (matice.Count == 2)
                return matice[0].Height * matice[1].Width * matice[1].Height;

            int nejmene = int.MaxValue;
            int nejmeneIdx = 0;
            for (int idx = 1; idx < matice.Count; idx++)
            {
                List<Matice> matice1 = new List<Matice>(matice);
                matice1.RemoveRange(idx, matice1.Count - idx);
                List<Matice> matice2 = new List<Matice>(matice);
                matice2.RemoveRange(0, idx);

                int kolikrat = NejminKolikrat(matice1) + NejminKolikrat(matice2);
                kolikrat += matice1[0].Height * matice2[matice2.Count - 1].Width * matice2[0].Height;

                if (kolikrat < nejmene)
                {
                    nejmene = kolikrat;
                    nejmeneIdx = idx;
                }
            }
            return nejmene;
        }

        static private void NejlipKolikrat(List<Matice> matice, 
            out List<Matice> matice1, out List<Matice> matice2)
        {
            int nejmene = int.MaxValue;
            int nejmeneIdx = 0;
            for (int idx = 1; idx < matice.Count; idx++)
            {
                matice1 = new List<Matice>(matice);
                matice1.RemoveRange(idx, matice1.Count - idx);
                matice2 = new List<Matice>(matice);
                matice2.RemoveRange(0, idx);

                int kolikrat = NejminKolikrat(matice1) + NejminKolikrat(matice2);
                kolikrat += matice1[0].Height * matice2[matice2.Count - 1].Width * matice2[0].Height;

                if (kolikrat < nejmene)
                {
                    nejmene = kolikrat;
                    nejmeneIdx = idx;
                }
            }

            matice1 = new List<Matice>(matice);
            matice1.RemoveRange(nejmeneIdx, matice1.Count - nejmeneIdx);
            matice2 = new List<Matice>(matice);
            matice2.RemoveRange(0, nejmeneIdx);
        }

        static private string NejlepsiNasobeni(List<Matice> matice)
        {
            if (matice.Count == 1)
                return matice[0].Name;
            if (matice.Count == 2)
                return "(" + matice[0].Name + " x " + matice[1].Name + ")";

            List<Matice> matice1;
            List<Matice> matice2;
            NejlipKolikrat(matice, out matice1, out matice2);

            return "(" + NejlepsiNasobeni(matice1) + " x " + NejlepsiNasobeni(matice2) + ")";
        }

        static private void TiskniMatice(List<string> radky)
        {
            int radkyIdx = 0;
            while (radkyIdx < radky.Count)
            {
                int pocet;
                int.TryParse(radky[radkyIdx], out pocet);
                radkyIdx++;

                if (pocet > 0)
                {
                    List<Matice> matice = new List<Matice>();
                    for (int maticeIdx = 0; maticeIdx < pocet; maticeIdx++)
                    {
                        // rozdel na cisla
                        string[] rozdeleni = radky[radkyIdx + maticeIdx].Split(' ');
                        List<string> cisla = new List<string>();
                        for (int cislaIdx = 0; cislaIdx < rozdeleni.Length; cislaIdx++)
                            if (!string.IsNullOrEmpty(rozdeleni[cislaIdx]))
                                cisla.Add(rozdeleni[cislaIdx]);
                        int height;
                        int.TryParse(cisla[0], out height);
                        int width;
                        int.TryParse(cisla[1], out width);
                        matice.Add(new Matice("A" + (maticeIdx + 1).ToString(), height, width));
                    }
                    Console.WriteLine(NejlepsiNasobeni(matice));
                }
                else
                    return;
                radkyIdx += pocet;
            }
        }

        static void Main(string[] args)
        {
            if (args.Length == 1)
            {
                if (File.Exists(args[0]))
                {
                    TextReader reader = null;
                    try
                    {
                        List<String> radky = new List<string>();

                        // precti soubor do listu radku
                        reader = new StreamReader(args[0]);
                        string radekSouboru = reader.ReadLine();
                        while (radekSouboru != null)
                        {
                            radky.Add(radekSouboru);
                            radekSouboru = reader.ReadLine();
                        }
                        reader.Close();
                        reader = null;

                        TiskniMatice(radky);
                    }
                    finally
                    {
                        if (reader != null)
                            reader.Close();
                    }
                }
                else
                {
                    Console.WriteLine("Zadany soubor '" + args[0] + "' neexistuje.");
                    Console.WriteLine("");
                }
            }

            Console.ReadKey();
        }
    }
}
