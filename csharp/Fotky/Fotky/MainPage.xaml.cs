using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.IO;
using System.Windows.Media.Imaging;
using System.Windows.Data;

namespace Fotky
{
    public partial class MainPage : UserControl
    {
        public class Fotka
        {
            public BitmapImage Obrazek { get; set; }
        }

        public MainPage()
        {
            InitializeComponent();
        }

        private void FotkyList()
        {
            List<Fotka> fotkaList = new List<Fotka>();

            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Multiselect = true;
            bool? result = ofd.ShowDialog();
            if (result.HasValue && result.Value)
            {
                int max = 20; // omezeni - pro mnoho fotek vyvolava vyjimku OutOfMemory...
                foreach (FileInfo soubor in ofd.Files)
                {
                    Fotka fotka = new Fotka();
                    fotka.Obrazek = new BitmapImage();
                    fotka.Obrazek.SetSource(soubor.OpenRead()); // silverlight umoznuje pouze cist soubor
                    fotkaList.Add(fotka);
                    max--;
                    if (max <= 0)
                        break;
                }
            }

            listBox.ItemsSource = fotkaList;
        }

        private void Button_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            FotkyList();
        }
    }
}
