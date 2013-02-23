using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using Mapper.Equipment.Foi;

namespace ArtrayFOI
{
    public partial class UcPictureBox : UserControl
    {
        #region private fields

        private bool isDesignRect;
        private Point designStartPoint;
        private Rectangle designRect;
        private Rectangle snapshotRect;

        private ArtCamBitmap artCamBitmap;

        #endregion

        #region constructors

        public UcPictureBox()
        {
            InitializeComponent();

            SetStyle(ControlStyles.DoubleBuffer | ControlStyles.UserPaint | ControlStyles.AllPaintingInWmPaint, true);
        }

        #endregion

        #region protected methods

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
        }

        protected override void OnPaintBackground(PaintEventArgs e)
        {
            base.OnPaintBackground(e);

            if (artCamBitmap != null)
                e.Graphics.DrawImage(artCamBitmap.Bitmap, new Rectangle(0, 0, Width, Height));
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            base.OnPaint(e);

            if (isDesignRect)
            {
                Pen pen = new Pen(Color.Red, 2f);
                pen.DashStyle = DashStyle.Dash;
                pen.DashPattern = new float[] { 8.0F, 4.0F };
                e.Graphics.DrawRectangle(pen, GetDrawingRect(designRect));
            }
            else
            {
                Pen pen = new Pen(Color.Red, 2f);
                e.Graphics.DrawRectangle(pen, GetDrawingRect(snapshotRect));
            }
        }

        protected override void OnResize(EventArgs e)
        {
            base.OnResize(e);
            Invalidate();
        }

        protected override void OnMouseDown(MouseEventArgs e)
        {
            base.OnMouseDown(e);

            isDesignRect = true;
            designStartPoint = new Point(e.X, e.Y);
            MouseMoved(e.X, e.Y);
            Invalidate();
        }

        protected override void OnMouseUp(MouseEventArgs e)
        {
            base.OnMouseUp(e);

            if (isDesignRect)
                isDesignRect = false;
            Invalidate();
        }

        protected override void OnMouseMove(MouseEventArgs e)
        {
            base.OnMouseMove(e);

            if (isDesignRect)
                MouseMoved(e.X, e.Y);

            if (MousePositionChanged != null)
            {
                EventHandler<MouseEventArgs> posChanged = MousePositionChanged;
                posChanged(this, e);
            }
        }

        #endregion

        #region private methods

        private void MouseMoved(int x, int y)
        {
            Rectangle rect;
            if (GetDrawnRect(x, y, out rect))
            {
                designRect = SnapshotRect = GetSnapshotRect(rect);
                Invalidate();
            }
        }

        private bool GetDrawnRect(int x, int y, out Rectangle rect)
        {
            int left = designStartPoint.X;
            int top = designStartPoint.Y;
            int width = x - left;
            if (width < 0)
            {
                left += width;
                width *= -1;
            }
            int height = y - top;
            if (height < 0)
            {
                top += height;
                height *= -1;
            }

            rect = Rectangle.Empty;
            if ((width != designRect.Width) || (height != designRect.Height))
            {
                rect = new Rectangle(left, top, width, height);
                return true;
            }
            return false;
        }

        private Rectangle GetSnapshotRect(Rectangle rect)
        {
            int left = (int)(rect.Left * RatioX);
            int top = (int)(rect.Top * RatioY);
            int width = (int)(rect.Width * RatioX);
            int height = (int)(rect.Height * RatioY);

            width = ((width + 2) / 4) * 4;

            return new Rectangle(left, top, width, height);
        }

        private Rectangle GetDrawingRect(Rectangle rect)
        {
            int left = (int)(rect.Left / RatioX);
            int top = (int)(rect.Top / RatioY);
            int width = (int)(rect.Width / RatioX);
            int height = (int)(rect.Height / RatioY);

            return new Rectangle(left, top, width, height);
        }

        private double RatioX
        {
            get { return (artCamBitmap != null) ? (double)artCamBitmap.Rect.Width / (double)Width : 1.0; }
        }

        private double RatioY
        {
            get { return (artCamBitmap != null) ? (double)artCamBitmap.Rect.Height / (double)Height : 1.0; }
        }

        private void BitmapUpdated(object sender, EventArgs e)
        {
            Invalidate();
        }

        #endregion

        #region public properties

        public event EventHandler<MouseEventArgs> MousePositionChanged;
        public event EventHandler SnapshotRectChanged;

        public ArtCamBitmap Bitmap
        {
            get { return artCamBitmap; }
            set
            {
                if (artCamBitmap != null)
                    artCamBitmap.BitmapUpdated -= new EventHandler(BitmapUpdated);

                artCamBitmap = value;

                if (artCamBitmap != null)
                    artCamBitmap.BitmapUpdated += new EventHandler(BitmapUpdated);
            }
        }

        public Rectangle SnapshotRect
        {
            get { return snapshotRect; }
            private set
            {
                if (snapshotRect != value)
                {
                    snapshotRect = value;
                    if (SnapshotRectChanged != null)
                    {
                        EventHandler rectChanged = SnapshotRectChanged;
                        rectChanged(this, EventArgs.Empty);
                    }
                }
            }
        }

        #endregion
    }
}
