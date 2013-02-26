using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Xml;
using System.Xml.Serialization;

namespace Ukoly
{
    public partial class FormUkoly : Form
    {
        #region private fields

        private List<Ukol> ukolList;
        private FormPozorUkol formPozorUkol;
        private int lastMinute;

        private const string taskFile = "ukoly.xml";

        #endregion

        #region constructors

        public FormUkoly()
        {
            InitializeComponent();

            ukolList = new List<Ukol>();
            formPozorUkol = null;
            lastMinute = -1;
        }

        #endregion

        #region private methods

        private int CompareByDate(Ukol x, Ukol y)
        {
            if ((x == null) && (y == null))
                return 0;
            else if (x == null)
                return -1;
            else if (y == null)
                return 1;

            return x.Datum.CompareTo(y.Datum);
        }

        private int SelectedIndex()
        {
            if (dgUkoly.SelectedCells.Count == 5)
            {
                Ukol ukol = dgUkoly.SelectedCells[4].Value as Ukol;
                return ukolList.IndexOf(ukol);
            }
            return -1;
        }

        private void SetridAUlozUkoly()
        {
            ukolList.Sort(CompareByDate);
            UlozUkoly();
        }

        private void ZobrazUkoly()
        {
            dgUkoly.Rows.Clear();
            for (int idx = 0; idx < ukolList.Count; idx++)
            {
                dgUkoly.Rows.Add();
                dgUkoly.Rows[idx].Cells[0].Value = ukolList[idx].Datum.ToString("dd.MM.yyyy - hh:mm");
                if (ukolList[idx].Dulezity)
                    dgUkoly.Rows[idx].Cells[1].Value = "!";
                if (ukolList[idx].Upozorneni)
                    dgUkoly.Rows[idx].Cells[2].Value = "A";
                dgUkoly.Rows[idx].Cells[3].Value = ukolList[idx].Text;
                dgUkoly.Rows[idx].Cells[4].Value = ukolList[idx];
            }
            dgUkoly.Sort(dgcDatum, ListSortDirection.Ascending);
        }

        private void PridejUkol(Ukol ukol)
        {
            if (ukol != null)
            {
                ukolList.Add(ukol);
                SetridAUlozUkoly();
            }
        }

        private void UpravUkol(int idx, Ukol ukol)
        {
            if ((idx >= 0) && (idx < ukolList.Count) && (ukol != null))
            {
                ukolList[idx] = ukol;
                SetridAUlozUkoly();
            }
        }

        private void SmazUkol(int idx)
        {
            if ((idx >= 0) && (idx < ukolList.Count))
            {
                ukolList.RemoveAt(idx);
            }
        }

        private void SmazUpozorneni()
        {
            DateTime datum = DateTime.Now;
            for (int idx = 0; idx < ukolList.Count; idx++)
                if (ukolList[idx].Datum < datum)
                    ukolList[idx].Upozorneni = false;
        }

        private void VyplnUpozorneni(ListBox listBox, List<Ukol> upozorneniList)
        {
            listBox.Items.Clear();
            for (int idx = 0; idx < upozorneniList.Count; idx++)
                listBox.Items.Add(upozorneniList[idx].Datum.ToString("dd.MM.yyyy hh:mm") + " - " + upozorneniList[idx].Text);
        }

        private delegate void InvokeUpozorneni(List<Ukol> upozorneniList);

        private void Upozorneni(List<Ukol> upozorneniList)
        {
            if (formPozorUkol == null)
            {
                formPozorUkol = new FormPozorUkol();

                VyplnUpozorneni(formPozorUkol.lbUkoly, upozorneniList);

                formPozorUkol.ShowDialog();

                SmazUpozorneni();
                ZobrazUkoly();

                formPozorUkol = null;
            }
            else
            {
                VyplnUpozorneni(formPozorUkol.lbUkoly, upozorneniList);
            }
        }

        private void NactiUkoly()
        {
            StreamReader reader = null;
            XmlReader xmlReader = null;
            try
            {
                if (File.Exists(taskFile))
                {
                    reader = new StreamReader(taskFile);

                    xmlReader = XmlReader.Create(reader, new XmlReaderSettings());

                    xmlReader.ReadStartElement(); // root element

                    XmlSerializer serializer = new XmlSerializer(typeof(Ukol));
                    Ukol ukol = (Ukol)serializer.Deserialize(xmlReader);
                    while (ukol != null)
                    {
                        ukolList.Add(ukol);
                        ukol = (Ukol)serializer.Deserialize(xmlReader);
                    }
                }
            }
            catch (Exception ex)
            {
                //throw new Exception("Ukoly.NactiUkoly: " + ex.Message);
            }
            finally
            {
                if (xmlReader != null)
                    xmlReader.Close();
                if (reader != null)
                    reader.Close();
            }
        }

        private void UlozUkoly()
        {
            StreamWriter writer = null;
            XmlWriter xmlWriter = null;
            try
            {
                writer = new StreamWriter(taskFile, false);

                XmlWriterSettings writerSettings = new XmlWriterSettings();
                writerSettings.Indent = true;
                writerSettings.Encoding = Encoding.ASCII;

                xmlWriter = XmlWriter.Create(writer, writerSettings);
                xmlWriter.WriteStartDocument();
                xmlWriter.WriteStartElement("root");

                XmlSerializer serializer = new XmlSerializer(typeof(Ukol));
                for (int idx = 0; idx < ukolList.Count; idx++)
                    serializer.Serialize(xmlWriter, ukolList[idx]);

                xmlWriter.WriteEndElement(); // root
                xmlWriter.WriteEndDocument();
            }
            catch (Exception ex)
            {
                throw new Exception("Ukoly.UlozUkoly: " + ex.Message);
            }
            finally
            {
                if (xmlWriter != null)
                    xmlWriter.Close();
                if (writer != null)
                    writer.Close();
            }
        }

        #endregion

        #region event handlers

        private void FormUkoly_Load(object sender, EventArgs e)
        {
            NactiUkoly();
            ZobrazUkoly();
        }

        private void btnNovy_Click(object sender, EventArgs e)
        {
            FormEditUkol form = new FormEditUkol();

            DialogResult result = form.ShowDialog();

            if (result == DialogResult.OK)
            {
                Ukol ukol = new Ukol(form.dtpDatum.Value, form.cbDulezity.Checked, form.cbUpozorneni.Checked, form.tbUkol.Text);
                PridejUkol(ukol);
                ZobrazUkoly();
            }
        }

        private void BtnEdit_Click(object sender, EventArgs e)
        {
            FormEditUkol form = new FormEditUkol();

            int idx = SelectedIndex();

            if ((idx >= 0) && (idx < ukolList.Count))
            {
                form.dtpDatum.Value = ukolList[idx].Datum;
                form.cbDulezity.Checked = ukolList[idx].Dulezity;
                form.cbUpozorneni.Checked = ukolList[idx].Upozorneni;
                form.tbUkol.Text = ukolList[idx].Text;

                DialogResult result = form.ShowDialog();

                if (result == DialogResult.OK)
                {
                    Ukol ukol = new Ukol(form.dtpDatum.Value, form.cbDulezity.Checked, form.cbUpozorneni.Checked, form.tbUkol.Text);
                    UpravUkol(idx, ukol);
                    ZobrazUkoly();
                }
            }
        }

        private void btnSmaz_Click(object sender, EventArgs e)
        {
            SmazUkol(SelectedIndex());
            ZobrazUkoly();
        }

        private void dgUkoly_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            BtnEdit_Click(sender, e);
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            timer.Enabled = false;

            DateTime datum = DateTime.Now;

            if (datum.Minute != lastMinute)
            {
                List<Ukol> upozorneniList = new List<Ukol>();

                for (int idx = 0; idx < ukolList.Count; idx++)
                    if (ukolList[idx].Upozorneni && (ukolList[idx].Datum < datum))
                        upozorneniList.Add(ukolList[idx]);

                if (upozorneniList.Count > 0)
                {
                    this.BeginInvoke(new InvokeUpozorneni(Upozorneni), upozorneniList);
                }
                lastMinute = datum.Minute;
            }

            timer.Enabled = true;
        }

        #endregion
    }
}