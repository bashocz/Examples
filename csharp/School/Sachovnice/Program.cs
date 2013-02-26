using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace Sachovnice
{
    /// <summary>
    /// Trida urcujici pozici figurky na sachovnici.
    /// </summary>
    class Pozice
    {
        private int x;
        private int y;

        /// <summary>
        /// Konstruktor.
        /// </summary>
        public Pozice()
            : this(0, 0) { }

        /// <summary>
        /// Konstruktor.
        /// </summary>
        /// <param name="x">Integer hodnota sloupce.</param>
        /// <param name="y">Integer hodnota radku.</param>
        public Pozice(int x, int y)
        {
            this.x = x;
            this.y = y;
        }

        /// <summary>
        /// Prevede pozici na retezec, kde sloupec je nahrazen malymi posmeny "a".."h" a radky jsou cisla 1..8
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return Convert.ToChar(x + 96) + y.ToString();
        }

        /// <summary>
        /// Vrati pozici sloupce.
        /// </summary>
        public int X
        {
            get { return x; }
        }

        /// <summary>
        /// Vrati pozici radku.
        /// </summary>
        public int Y
        {
            get { return y; }
        }
    }

    /// <summary>
    /// Trida urcujici figurku na sachovnici.
    /// </summary>
    class Figurka
    {
        private Pozice pozice;
        private string jmeno;

        /// <summary>
        /// Konstruktor.
        /// </summary>
        public Figurka()
            : this(new Pozice(0, 0), string.Empty) { }

        /// <summary>
        /// Konstruktor.
        /// </summary>
        /// <param name="pozice">Pozice figurky.</param>
        /// <param name="jmeno">Jmeno figurky.</param>
        public Figurka(Pozice pozice, string jmeno)
        {
            this.pozice = pozice;
            this.jmeno = jmeno;
        }

        /// <summary>
        /// Prevede pozici figurky na retezec.
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            if (Hodnota > 0)
                return jmeno.ToUpper() + pozice.ToString();
            return pozice.ToString();
        }

        /// <summary>
        /// Vrati pozici figurky.
        /// </summary>
        public Pozice Pozice
        {
            get { return pozice; }
        }

        /// <summary>
        /// Vrati jmeno figurky.
        /// </summary>
        public string Jmeno
        {
            get { return jmeno; }
        }

        /// <summary>
        /// Vrati hodnotu figurky, pro jeji trideni.
        /// </summary>
        public int Hodnota
        {
            get
            {
                switch (jmeno)
                {
                    case "K":
                    case "k":
                        return 5;
                    case "Q":
                    case "q":
                        return 4;
                    case "R":
                    case "r":
                        return 3;
                    case "B":
                    case "b":
                        return 2;
                    case "N":
                    case "n":
                        return 1;
                }
                return 0;
            }
        }
    }

    class Program
    {
        /// <summary>
        /// Precte sachovnici ze souboru a ulozi pozice figurek do poli.
        /// </summary>
        /// <param name="jmenoSouboru">Jmeno souboru.</param>
        /// <param name="figurkyBily">Vrati pole bilych figurek.</param>
        /// <param name="figurkyCerny">Vrati pole cernych figurek.</param>
        /// <returns>Vrati true, pokud nacteni ze souboru bylo uspesne, jinak false.</returns>
        static bool NactiSoubor(string jmenoSouboru, out List<Figurka> figurkyBily, out List<Figurka> figurkyCerny)        
        {
            figurkyBily = new List<Figurka>();
            figurkyCerny = new List<Figurka>();
            TextReader reader = null;
            try
            {
                List<String> radky = new List<string>();

                // precti soubor do listu radku
                reader = new StreamReader(jmenoSouboru);
                string radekSouboru = reader.ReadLine();
                while (radekSouboru != null)
                {
                    radky.Add(radekSouboru);
                    radekSouboru = reader.ReadLine();
                }
                reader.Close();
                reader = null;

                // zakladni kontrola formatu souboru
                if (radky.Count != 17)
                    return false;
                foreach (string radek in radky)
                    if (radek.Length != 33)
                        return false;

                // parse radky s figurkama (bez dukladnejsi kontroly formatu souboru, ktery by se mohl pridat)
                int j = 8;
                foreach (string radek in radky)
                {
                    // rozdel na jednotliva pole
                    string[] poleRadek = radek.Split('|');
                    // pokud je to zadek s figurkama pak 10 (8 + prvni a posledni je prazdny retezec)
                    if (poleRadek.Length == 10)
                    {
                        int i = 0;
                        foreach (string pole in poleRadek)
                        {
                            if (pole.Length == 3)
                            {
                                i++;
                                string figurkaJmeno = pole.Substring(1, 1);
                                if (Char.IsLetter(figurkaJmeno[0]))
                                {
                                    if (Char.IsUpper(figurkaJmeno[0]))
                                        figurkyBily.Add(new Figurka(new Pozice(i, j), figurkaJmeno));
                                    else
                                        figurkyCerny.Add(new Figurka(new Pozice(i, j), figurkaJmeno));
                                }
                            }
                        }
                        j--;
                    }
                }
            }
            catch
            {
                return false;
            }
            finally
            {
                if (reader != null)
                    reader.Close();
            }
            return true;
        }

        /// <summary>
        /// Porovna figurky pro serazeni v poli.
        /// </summary>
        /// <param name="f1">Prvni figurka.</param>
        /// <param name="f2">Druha figurka.</param>
        /// <returns>0 = jsou stejne, -1 = prvni figurka je vyssi, 1 = druha figurka je vyssi.</returns>
        static int CompareFigurky(Figurka f1, Figurka f2)
        {
            // Radi figurky sestupne (od nejvyssi po nejnizsi)
            if (f1.Hodnota > f2.Hodnota)
                return -1;
            else if (f1.Hodnota < f2.Hodnota)
                return 1;
            else
            {
                // stejne hodnoty figurek, radi podle pozice na sachovnici
                if (f1.Pozice.Y != f2.Pozice.Y)
                {
                    if (Char.IsUpper(f1.Jmeno[0]))
                    {
                        // bile figurky od nejnizsiho radku
                        if (f1.Pozice.Y > f2.Pozice.Y)
                            return 1;
                        else
                            return -1;
                    }
                    else
                    {
                        // cerne figurky od nejvyssiho radku
                        if (f1.Pozice.Y < f2.Pozice.Y)
                            return 1;
                        else
                            return -1;
                    }
                }
                else
                {
                    // stejny radek, radi podle sloupcu
                    if (f1.Pozice.X > f2.Pozice.X)
                        return 1;
                    else if (f1.Pozice.X < f2.Pozice.X)
                        return -1;
                }
            }
            // toto jsou stejne figurky, na stejne pozici - v praxi nemuze nastat
            return 0;
        }

        /// <summary>
        /// Vytiskne list figurek.
        /// </summary>
        /// <param name="figurky">List figurek.</param>
        static void TiskFigurek(List<Figurka> figurky)
        {
            figurky.Sort(CompareFigurky);

            for (int i = 0; i < figurky.Count; i++)
                if (i == 0)
                    Console.Write(figurky[i].ToString());
                else
                    Console.Write(", " + figurky[i].ToString());
            Console.WriteLine();
        }

        /// <summary>
        /// Vytiskne help.
        /// </summary>
        static void TiskPomoc()
        {
            Console.WriteLine("Sachovnice.exe JmenoSouboru");
            Console.WriteLine("");
            Console.WriteLine("Textovy soubor musi mit nasleduji format:");
            Console.WriteLine("");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|.r.|:::|.b.|:q:|.k.|:::|.n.|:r:|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|:p:|.p.|:p:|.p.|:p:|.p.|:::|.p.|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|...|:::|.n.|:::|...|:::|...|:p:|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|:::|...|:::|...|:::|...|:::|...|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|...|:::|...|:::|.P.|:::|...|:::|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|:P:|...|:::|...|:::|...|:::|...|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|.P.|:::|.P.|:P:|...|:P:|.P.|:P:|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("|:R:|.N.|:B:|.Q.|:K:|.B.|:::|.R.|");
            Console.WriteLine("+---+---+---+---+---+---+---+---+");
            Console.WriteLine("");
            Console.WriteLine("Kde:");
            Console.WriteLine("");
            Console.WriteLine("Velke pismena oznacuji bile figurky, mala pismena oznacuji cerne figurky");
            Console.WriteLine("'K','k' - Kral");
            Console.WriteLine("'Q','q' - Dama");
            Console.WriteLine("'R','r' - Vez");
            Console.WriteLine("'B','b' - Strelec");
            Console.WriteLine("'N','n' - Kun");
            Console.WriteLine("'P','p' - Pesec");
            Console.WriteLine("");
            Console.WriteLine("'+','-','|' - vyznacuji tvar sachovnice");
            Console.WriteLine("'.' - oznacuje bile pole");
            Console.WriteLine("':' - oznacuje cerne pole");
            Console.WriteLine("");
            Console.WriteLine("Priklad:");
            Console.WriteLine("Sachovnice.exe C:\\zapis.txt");

        }

        static void Main(string[] args)
        {
            if ((args.Length == 1) && (string.Compare(args[0], "/?") != 0) && (string.Compare(args[0], "/H", true) != 0))
            {
                if (File.Exists(args[0]))
                {
                    List<Figurka> figurkyBily = new List<Figurka>();
                    List<Figurka> figurkyCerny = new List<Figurka>();
                    if (NactiSoubor(args[0], out figurkyBily, out figurkyCerny))
                    {
                        Console.Write("White: ");
                        TiskFigurek(figurkyBily);
                        Console.Write("Black: ");
                        TiskFigurek(figurkyCerny);
                    }
                    else
                    {
                        Console.WriteLine("Spatny format souboru '" + args[0] + "'.");
                        Console.WriteLine("");
                        TiskPomoc();
                    }
                }
                else
                {
                    Console.WriteLine("Zadany soubor '" + args[0] + "' neexistuje.");
                    Console.WriteLine("");
                    TiskPomoc();
                }
            }
            else
                TiskPomoc();

            Console.ReadKey();
        }
    }
}
