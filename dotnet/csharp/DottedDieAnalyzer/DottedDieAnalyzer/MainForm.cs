using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Text;
using System.Windows.Forms;

namespace Basho.DottedDieAnalyzer
{
    public partial class MainForm : Form
    {
        private List<ImageInfo> images = new List<ImageInfo>();
        private string dirName;

        public MainForm()
        {
            InitializeComponent();

            backgroundWorker1.DoWork += new DoWorkEventHandler(backgroundWorker1_DoWork);
        }

        private delegate void InvokeViewImageRow(ImageInfo image, int row);

        private void ViewImageRow(ImageInfo image, int row)
        {
            dataGridView1.Rows[row].Cells[0].Value = image.FileName;
            dataGridView1.Rows[row].Cells[1].Value = image.IsDot;
            dataGridView1.Rows[row].Cells[2].Value = image.Time.ToString();
            dataGridView1.Rows[row].Cells[3].Value = string.Empty;
        }

        private delegate void InvokeRunningImageRow(int row);

        private void RunningImageRow(int row)
        {
            dataGridView1.Rows[row].Cells[3].Value = "Y";
        }

        private void ViewImages()
        {
            dataGridView1.Rows.Clear();
            int row = 0;
            foreach(ImageInfo image in images)
            {
                dataGridView1.Rows.Add();
                ViewImageRow(image, row);
                row++;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (folderBrowserDialog1.ShowDialog() != DialogResult.Cancel)
            {
                dirName = folderBrowserDialog1.SelectedPath;
                textBox1.Text = dirName;

                images.Clear();
                string[] fileNames = Directory.GetFiles(dirName, "*.png");
                foreach (string fileName in fileNames)
                    if (File.Exists(fileName))
                        images.Add(new ImageInfo(fileName));

                ViewImages();
            }
        }

        private void dataGridView1_SelectionChanged(object sender, EventArgs e)
        {
            if (dataGridView1.SelectedRows.Count > 0)
            {
                DataGridViewRow row = dataGridView1.SelectedRows[0];
                pictureBox1.ImageLocation = images[row.Index].FullFileName;
            }
        }

        void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            int row = 0;
            foreach(ImageInfo image in images)
            {
                Invoke(new InvokeRunningImageRow(RunningImageRow), row);
                DateTime start = DateTime.Now;
                ImageInkFinder finder = new ImageConverter().GetImageInkFinder(image.FullFileName);
                image.IsDot = finder.IsInk();
                image.Time = DateTime.Now - start;
                Invoke(new InvokeViewImageRow(ViewImageRow), image, row);
                row++;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (!backgroundWorker1.IsBusy)
            {
                backgroundWorker1.RunWorkerAsync();
            }
        }
    }
}