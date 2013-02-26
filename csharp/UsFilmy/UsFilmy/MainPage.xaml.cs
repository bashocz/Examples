using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Browser;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Windows.Media.Imaging;
using System.Xml.Linq;

// Projekt vyuziva komponenty z toolkit november 2009 od microsoftu
//  - je treba instalovat
// Adressa
// http://www.codeplex.com/Silverlight

namespace UsFilmy
{
    public class Vysledky
    {
        static System.Globalization.NumberFormatInfo ni = null;

        public Vysledky()
        {
            System.Globalization.CultureInfo ci =
               System.Globalization.CultureInfo.CurrentCulture;
            ni = (System.Globalization.NumberFormatInfo)
               ci.NumberFormat.Clone();
            ni.NumberDecimalSeparator = ".";
        }

        public string Titulek { get; set; }
        public string ObrazekMaly { get; set; }
        public string ObrazekVelky { get; set; }
        public string Rok { get; set; }
        public string Hodnoceni { get; set; }
        public double Hvezdicky
        {
            get
            {
                if (!string.IsNullOrEmpty(Hodnoceni))
                    return (Convert.ToDouble(Hodnoceni, ni) / 5);
                return 0;
            }
        }
    }

    public partial class MainPage : UserControl
    {
        private OAuth.OAuthBase oauth;
        private WebClient client;

        private int zIndex = 0;

        public MainPage()
        {
            InitializeComponent();

            oauth = new OAuth.OAuthBase();
            client = new WebClient();

            // stisk <Enter> v editacnim poli
            tbHledat.KeyUp +=
                (sender, e) =>
                {
                    if (e.Key == Key.Enter)
                        Hledani();
                };

            // stisk tlacitka Hledej
            btnHledej.Click +=
                (sender, e) =>
                    Hledani();

            // callback pokud dojde odpoved ze serveru
            client.DownloadStringCompleted +=
                (sender, e) =>
                {
                    if (e.Error == null)
                        XmlVysledky(e.Result);
                };

            // prvni hledani
            Hledani();
        }

        private void Hledani()
        {
            // WebClient muze vyridit pouze jeden dotaz soubezne
            if (!client.IsBusy)
            {
                client.DownloadStringAsync(VytvorDotaz(tbHledat.Text));
                // Busy indikator
                biHledani.IsBusy = true;
            }
        }

        private void XmlVysledky(string xml)
        {
            try
            {
                XDocument doc = XDocument.Parse(xml);

                // LINQ
                lbVysledky.ItemsSource =
                    from result in doc.Descendants("catalog_title")
                    select new Vysledky()
                    {
                        Titulek = result.Element("title").Attribute("regular").Value,
                        ObrazekMaly = result.Element("box_art").Attribute("medium").Value,
                        ObrazekVelky = result.Element("box_art").Attribute("large").Value,
                        Rok = result.Element("release_year").Value,
                        Hodnoceni = result.Element("average_rating").Value
                    };
            }
            catch (Exception)
            {
                // spatne XML
                return;
            }

            // aktivni je prvni vysledek
            if (lbVysledky.Items.Count > 0)
                lbVysledky.SelectedItem = lbVysledky.Items[0];

            // smazani starych a vytvoreni novych karet s filmy
            gridProjection.Children.Clear();
            if (lbVysledky.Items.Count > 0)
            {
                for (int idx = lbVysledky.Items.Count - 1; idx >= 0; idx--)
                {
                    FilmInfo info = new FilmInfo();
                    info.MouseLeftButtonUp += OtocObrazek;
                    info.spInfo.DataContext = lbVysledky.Items[idx];

                    gridProjection.Children.Add(info);
                }
            }
            // Busy indikator
            biHledani.IsBusy = false;
        }

        private Uri VytvorDotaz(string title)
        {
            string normalizedUrl;
            string normalizedReqParams;

            string uri = "http://api.netflix.com/" + "catalog/titles?max_results=15&term=" + title;

            string signature =
                oauth.GenerateSignature(
                    new Uri(uri),
                    "36ahfvkxv63b7wm458q5tdts", // muj uzivatesky autorizacni string
                    "Kamy55ceSu", // muj uzivatelsky tajny string
                    null, null,
                    "GET",
                    oauth.GenerateTimeStamp(),
                    oauth.GenerateNonce(),
                    out normalizedUrl,
                    out normalizedReqParams);

            signature = HttpUtility.UrlEncode(signature);

            return new Uri(
                normalizedUrl + "?" +
                normalizedReqParams +
                "&oauth_signature=" +
                signature);
        }

        private void OtocObrazek(object sender, MouseButtonEventArgs e)
        {
            FilmInfo info = sender as FilmInfo;

            // Posun obrazek pred vsechny ostatni.
            info.SetValue(Canvas.ZIndexProperty, zIndex++);

            Storyboard otocka = new Storyboard();
            DoubleAnimation animace = new DoubleAnimation()
            {
                Duration = new TimeSpan(0, 0, 1)
            };
            otocka.Children.Add(animace);

            // Vytvor projekci, pokud jeste neexistuje.
            if (info.Projection == null)
            {
                // Nastavi center rotace na -0.01, ktery vytvori malou mezeru, pokud se obrazek otoci.
                info.Projection = new PlaneProjection()
                {
                    CenterOfRotationX = -0.01
                };
            }

            PlaneProjection projekce = info.Projection as PlaneProjection;
            if (projekce.RotationY == 0)
            {
                animace.To = 180;
            }
            else
            {
                animace.From = 180;
                animace.To = 0;
            }

            // Animace ma animovat predtim definovanou projekci.
            Storyboard.SetTarget(animace, projekce);

            // Animace ma animovat danou property.
            Storyboard.SetTargetProperty(animace, new PropertyPath(PlaneProjection.RotationYProperty));

            otocka.Begin();
        }
    }
}
