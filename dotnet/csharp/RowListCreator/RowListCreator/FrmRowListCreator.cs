using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Basho.Wafer;

namespace Basho.RowListCreator
{
    public partial class FrmRowListCreator : Form
    {
        DrawWafer DrawingWafer;
        DrawColor DieColor;
        DieStatus DrawingDie;

        public FrmRowListCreator()
        {
            InitializeComponent();
            DieColor = new DrawColor();

            PnlStatus1.BackColor = DieColor.TestedDie;
            PnlStatus2.BackColor = DieColor.SkippedDie;
            PnlStatus3.BackColor = DieColor.UntestedDie;
            PnlStatus4.BackColor = DieColor.FirstDie;
            PnlStatus5.BackColor = DieColor.ZeroDie;
            SetActiveDieStatus(DieStatus.TestedDie);

            DefaultVariables(); // only for fast debugging
        }

        private void DefaultVariables()
        {
            EdtWaferDiam.Value = 200;
            EdtDieX.Value = (decimal)2.032;
            EdtDieY.Value = (decimal)2.270;
            CbFlatPos.SelectedIndex = 1;

            NewWafer();
        }

        private void NewWafer()
        {
            DrawingWafer = new DrawWafer(DrawDieMode.WaferEditor, (float)EdtWaferDiam.Value,
                (FlatPosition)Enum.Parse(typeof(FlatPosition), CbFlatPos.Text),
                (float)EdtDieX.Value, (float)EdtDieY.Value);
            DrawingWafer.CanvasSize = new Size(PnlCanvas.Width, PnlCanvas.Height);
            DefaultScrollBars();
        }

        private void DefaultScrollBars()
        {
            Size waferSize = DrawingWafer.WaferSize;

            if (waferSize.Width > PnlCanvas.Width)
            {
                WaferHScrollBar.Enabled = true;
                if (WaferHScrollBar.Value > (waferSize.Width - PnlCanvas.Width))
                    WaferHScrollBar.Value = waferSize.Width - PnlCanvas.Width + 1;
                WaferHScrollBar.Maximum = waferSize.Width;
                WaferHScrollBar.LargeChange = PnlCanvas.Width;
            }
            else
            {
                WaferHScrollBar.Value = 0;
                WaferHScrollBar.Maximum = 100;
                WaferHScrollBar.LargeChange = 10;
                WaferHScrollBar.Enabled = false;
            }
            if (waferSize.Height > PnlCanvas.Height)
            {
                WaferVScrollBar.Enabled = true;
                if (WaferVScrollBar.Value > (waferSize.Height - PnlCanvas.Height))
                    WaferVScrollBar.Value = waferSize.Height - PnlCanvas.Height + 1;
                WaferVScrollBar.Maximum = waferSize.Height;
                WaferVScrollBar.LargeChange = PnlCanvas.Height;
            }
            else
            {
                WaferVScrollBar.Value = 0;
                WaferVScrollBar.Maximum = 100;
                WaferVScrollBar.Enabled = false;
                WaferVScrollBar.LargeChange = 10;
            }
            DrawingWafer.LeftTop = new Point(WaferHScrollBar.Value, WaferVScrollBar.Value);
        }

        private void PaintWafer()
        {
            Bitmap Bmp = new Bitmap(PnlCanvas.Size.Width, PnlCanvas.Size.Height);
            Graphics Canvas = Graphics.FromImage(Bmp);
            DrawingWafer.Paint(Canvas);
            Canvas = PnlCanvas.CreateGraphics();
            Canvas.DrawImage(Bmp, 0, 0, PnlCanvas.Size.Width, PnlCanvas.Size.Height);
        }

        private void PaintDie(Point die)
        {
            Graphics canvas = PnlCanvas.CreateGraphics();
            DrawingWafer.SetDieStatus(die, DrawingDie);
            DrawingWafer.PaintDie(canvas, die);
        }

        private void ChangeZoom()
        {
            DrawingWafer.Zoom = (int)EdtZoom.Value;
            DefaultScrollBars();
            PaintWafer();
        }

        private void SetActiveDieStatus(DieStatus status)
        {
            DrawingDie = status;
            if (status == DieStatus.TestedDie)
                LblStatus1.BorderStyle = BorderStyle.FixedSingle;
            else
                LblStatus1.BorderStyle = BorderStyle.None;
            if (status == DieStatus.SkippedDie)
                LblStatus2.BorderStyle = BorderStyle.FixedSingle;
            else
                LblStatus2.BorderStyle = BorderStyle.None;
            if (status == DieStatus.UntestedDie)
                LblStatus3.BorderStyle = BorderStyle.FixedSingle;
            else
                LblStatus3.BorderStyle = BorderStyle.None;
            if (status == DieStatus.FirstDie)
                LblStatus4.BorderStyle = BorderStyle.FixedSingle;
            else
                LblStatus4.BorderStyle = BorderStyle.None;
            if (status == DieStatus.ZeroDie)
                LblStatus5.BorderStyle = BorderStyle.FixedSingle;
            else
                LblStatus5.BorderStyle = BorderStyle.None;
        }

        private void PnlCanvas_Resize(object sender, EventArgs e)
        {
            if (DrawingWafer != null)
            {
                DrawingWafer.CanvasSize = new Size(PnlCanvas.Width, PnlCanvas.Height);
                DefaultScrollBars();
                PaintWafer();
            }
        }

        private void PnlCanvas_Paint(object sender, PaintEventArgs e)
        {
            if (DrawingWafer != null)
                PaintWafer();
        }

        private void PnlCanvas_MouseMove(object sender, MouseEventArgs e)
        {
            if (DrawingWafer != null)
            {
                Point die = DrawingWafer.GetDieShiftXYCoord(e.Location);
                if (DrawingWafer.IsInShithRange(die))
                {
                    LblDieXPos.Text = "X: " + die.X.ToString();
                    LblDieYPos.Text = "Y: " + die.Y.ToString();
                }
                else
                {
                    LblDieXPos.Text = "X: out";
                    LblDieYPos.Text = "Y: out";
                }
                if (e.Button == MouseButtons.Left)
                    PaintDie(DrawingWafer.GetDieXYCoord(e.Location));
            }
        }

        private void PnlCanvas_MouseDown(object sender, MouseEventArgs e)
        {
            if (DrawingWafer != null)
            {
                if (e.Button == MouseButtons.Left)
                    PaintDie(DrawingWafer.GetDieXYCoord(e.Location));
            }
        }

        private void WaferHScrollBar_Scroll(object sender, ScrollEventArgs e)
        {
            if (DrawingWafer != null)
            {
                DrawingWafer.LeftTop = new Point(WaferHScrollBar.Value, WaferVScrollBar.Value);
                PaintWafer();
            }
        }

        private void WaferVScrollBar_Scroll(object sender, ScrollEventArgs e)
        {
            if (DrawingWafer != null)
            {
                DrawingWafer.LeftTop = new Point(WaferHScrollBar.Value, WaferVScrollBar.Value);
                PaintWafer();
            }
        }

        private void StatusX_Click(object sender, EventArgs e)
        {
            if ((sender.Equals(PnlStatus1)) || (sender.Equals(LblStatus1)))
                SetActiveDieStatus(DieStatus.TestedDie);
            if ((sender.Equals(PnlStatus2)) || (sender.Equals(LblStatus2)))
                SetActiveDieStatus(DieStatus.SkippedDie);
            if ((sender.Equals(PnlStatus3)) || (sender.Equals(LblStatus3)))
                SetActiveDieStatus(DieStatus.UntestedDie);
            if ((sender.Equals(PnlStatus4)) || (sender.Equals(LblStatus4)))
                SetActiveDieStatus(DieStatus.FirstDie);
            if ((sender.Equals(PnlStatus5)) || (sender.Equals(LblStatus5)))
                SetActiveDieStatus(DieStatus.ZeroDie);
        }

        private void EdtZoom_ValueChanged(object sender, EventArgs e)
        {
            if (DrawingWafer != null)
                ChangeZoom();
        }

        private void BtnCreate_Click(object sender, EventArgs e)
        {
            DialogResult result =
                MessageBox.Show("Edited row list will be lost and\nnew row list will be created.\nDo you want to continue?",
                "Confirmation", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                DrawingWafer = null;
                EdtZoom.Value = 1;
                NewWafer();
                PaintWafer();
            }
        }

        private void MenuAbout_Click(object sender, EventArgs e)
        {
            FrmAbout frmAbout = new FrmAbout();
            frmAbout.ShowDialog();
        }

        private void Exit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void FrmRowListCreator_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult result =
                MessageBox.Show("Do you want to close the application?", "Confirmation",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            e.Cancel = (result == DialogResult.No);
        }
    }
}