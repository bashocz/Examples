using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Drawing.Imaging;
using Mapper.Equipment.Foi;
using ArtCamSdk;

namespace ArtrayFOI
{
    public partial class FormMain : Form
    {
        private readonly ArtCamHelper helper = new ArtCamHelper();

        private ArtCamBitmap preview;
        private ArtCamBitmap snapshot;

        private TimeMeter previewMeter = new TimeMeter();
        private TimeMeter snapshotMeter = new TimeMeter();

        Random random = new Random();

        public FormMain()
        {
            InitializeComponent();
        }

        private void FormMain_Load(object sender, EventArgs e)
        {
            ARTCAM_CAMERATYPE dllType = helper.Initialize(IntPtr.Zero);
            Text = "DLL type: " + Enum.GetName(typeof(ARTCAM_CAMERATYPE), dllType);

            helper.SetColorMode(8);

            ucPictureBox1.MousePositionChanged += new EventHandler<MouseEventArgs>(MousePositionChanged);
            ucPictureBox1.SnapshotRectChanged += new EventHandler(SnapshotRectChanged);
        }

        private void FormMain_FormClosed(object sender, FormClosedEventArgs e)
        {
            helper.Release();
        }

        void SnapshotRectChanged(object sender, EventArgs e)
        {
            label4.Text = "(" + ucPictureBox1.SnapshotRect + ")";
        }

        void MousePositionChanged(object sender, MouseEventArgs e)
        {
            label3.Text = "(" + e.X + "," + e.Y + ")";
        }

        private void BitmapUpdated(object sender, EventArgs e)
        {
            pictureBox1.Invalidate();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (preview == null)
            {
                preview = new ArtCamBitmap(new Rectangle(0, 0, 3488, 2616), PixelFormat.Format8bppIndexed, helper);
                ucPictureBox1.Bitmap = preview;
            }

            try
            {
                previewMeter.Clear();
                preview.Snapshot(previewMeter);
                preview.UpdateBitmap(previewMeter);
                previewMeter.Finish();
            }
            catch (ApplicationException ex)
            {
                MessageBox.Show("Exception: " + ex.Message);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if ((snapshot == null) || (snapshot.Rect != ucPictureBox1.SnapshotRect))
            {
                snapshot = new ArtCamBitmap(ucPictureBox1.SnapshotRect, PixelFormat.Format8bppIndexed, helper);
                snapshot.BitmapUpdated += new EventHandler(BitmapUpdated);

                pictureBox1.Image = snapshot.Bitmap;
            }
            bool isInk = false;
            try
            {
                snapshotMeter.Clear();

                snapshot.Snapshot(snapshotMeter);

                ImageConvertor converter = new ImageConvertor(snapshot);
                ArtCamBitmap convertBmp = converter.GetImageAnalyzer(snapshotMeter, true);
                ImageAnalyzer analyzer = new ImageAnalyzer(convertBmp.Pixels, convertBmp.Bitmap.PixelFormat, convertBmp.Rect.Width, convertBmp.Rect.Height);
                label7.Text = "(" + convertBmp.Rect.Width + "," + convertBmp.Rect.Height + ")";
                //ImageAnalyzer analyzer = new ImageAnalyzer(snapshot.Pixels, snapshot.Bitmap.PixelFormat, snapshot.Rect.Width, snapshot.Rect.Height);
                isInk = analyzer.IsInk(snapshotMeter);

                ArtCamBitmap bwBmp = analyzer.GetBwBitmap();
                bwBmp.UpdateBitmap(null);
                pictureBox2.Image = bwBmp.Bitmap;
                pictureBox2.Invalidate();

                snapshot.UpdateBitmap(snapshotMeter);
                snapshotMeter.Finish();
            }
            catch (ApplicationException ex)
            {
                MessageBox.Show("Exception: " + ex.Message);
            }
            finally
            {
                TimeAnalysis();
                DisplayInk(isInk);
            }
        }

        private void DisplayInk(bool isInk)
        {
            if (isInk)
            {
                label5.Text = "INKED DICE";
                label5.ForeColor = Color.Red;
            }
            else
            {
                label5.Text = "GOOD DICE";
                label5.ForeColor = Color.Green;
            }
        }

        private void TimeAnalysis()
        {
            label6.Text = snapshotMeter.ToString();
        }
    }
}