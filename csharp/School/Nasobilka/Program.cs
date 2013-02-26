using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Nasobilka
{
    class Program
    {
        static List<string> NasobCisla(int cislo1, int cislo2)
        {
            List<string> radky = new List<string>();

            // nejprve cisla
            radky.Add(cislo1.ToString());
            radky.Add(cislo2.ToString());
            radky.Add("".PadRight(Math.Max(radky[0].Length, radky[1].Length), '-'));

            // samotne nasobeni
            if ((cislo1 > 0) && (cislo2 > 0))
            {
                int radek = 0;
                int cislo = cislo2;
                while (cislo > 0)
                {
                    int mezivysledek = cislo1 * (cislo % 10);
                    radky.Add(mezivysledek.ToString() + "".PadRight(radek));
                    cislo /= 10;
                    radek++;
                }
                if (radek > 1)
                {
                    string vysledek = (cislo1 * cislo2).ToString();
                    radky.Add("".PadRight(vysledek.Length, '-'));
                    radky.Add(vysledek);
                }
            }
            else
            {
                radky.Add("0");
            }

            // zformatovani vystupu
            int delka = 0;
            for (int idx = 0; idx < radky.Count; idx++)
                if (radky[idx].Length > delka)
                    delka = radky[idx].Length;
            for (int idx = 0; idx < radky.Count; idx++)
                radky[idx] = radky[idx].PadLeft(delka);

            return radky;
        }

        static bool TiskniNasobeni(string radek)
        {
            // rozdel na cisla
            string[] rozdeleni = radek.Split(' ');
            List<string> cisla = new List<string>();
            for (int idx = 0; idx < rozdeleni.Length; idx++)
                if (!string.IsNullOrEmpty(rozdeleni[idx]))
                    cisla.Add(rozdeleni[idx]);
            // zkus nasobit
            if (cisla.Count == 2)
            {
                int cislo1;
                int.TryParse(cisla[0], out cislo1);
                int cislo2;
                int.TryParse(cisla[1], out cislo2);
                List<string> radky = NasobCisla(cislo1, cislo2);
                for (int idx = 0; idx < radky.Count; idx++)
                    Console.WriteLine(radky[idx]);
                Console.WriteLine();
                return true;
            }
            return false;
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

                        for (int idx = 0; idx < radky.Count; idx++)
                            TiskniNasobeni(radky[idx]);
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
