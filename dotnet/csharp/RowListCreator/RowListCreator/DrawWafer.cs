using System;
using System.Drawing;

namespace Basho.Wafer
{
    public enum FlatPosition
    {
        Left,
        Right,
        Top,
        Bottom
    }

    public enum DieStatus
    {
        OutOfWafer, // out of wafer die and the status can't be change from outside
        UntestedDie,
        SkippedDie,
        TestedDie,
        FirstDie, // first die on wafer
        ZeroDie, // die with position [0, 0] on wafer grid
        FirstZeroDie // first die on wafer with position [0, 0]
    }

    public class WaferStatus
    {
        private Point FirstDieXY; // coordinates of first dei
        private Point LastFirstDieXY; // for editor mode only
        private Point ZeroDieXY; // coordinates of [0, 0] dei
        private Point LastZeroDieXY; // for editor mode only

        protected DieStatus[,] DieStsArr; // die array of status for measurement
        protected int[,] DieBinArr; // die array of bin value information
        protected Size WaferRange; // size of die arrays

        public WaferStatus(Size range)
        {
            if ((range.Width > 0) && (range.Height > 0))
            {
                FirstDieXY = new Point(0, 0);
                LastFirstDieXY = new Point(0, 0);
                ZeroDieXY = new Point(0, 0);
                LastZeroDieXY = new Point(0, 0);

                WaferRange = range;
                DieStsArr = new DieStatus[WaferRange.Width, WaferRange.Height];
                DieBinArr = new int[WaferRange.Width, WaferRange.Height];

                for (int idxX = 0; idxX < WaferRange.Width; idxX++)
                    for (int idxY = 0; idxY < WaferRange.Height; idxY++)
                    {
                        DieStsArr[idxX, idxY] = DieStatus.UntestedDie;
                        DieBinArr[idxX, idxY] = 0;
                    }
            }
        }

        public WaferStatus(int dieXCnt, int dieYCnt)
            : this(new Size(dieXCnt, dieYCnt))
        {
        }

        public Point FirstDie
        {
            set
            {
                if (IsInRange(value))
                {
                    LastFirstDieXY = FirstDieXY;
                    FirstDieXY = value;
                }
            }
            get { return FirstDieXY; }
        }

        public Point LastFirstDie
        {
            get { return LastFirstDieXY; }
        }

        public Point ZeroDie
        {
            set
            {
                if (IsInRange(value))
                {
                    LastZeroDieXY = ZeroDieXY;
                    ZeroDieXY = value;
                }
            }
            get { return ZeroDieXY; }
        }

        public Point LastZeroDie
        {
            get { return LastZeroDieXY; }
        }

        public bool IsInRange(Point die)
        {
            return ((die.X >= 0) && (die.X < WaferRange.Width) && (die.Y >= 0) && (die.Y < WaferRange.Height));
        }

        public bool IsInShithRange(Point die)
        {
            die = ConvertToAbsoluteCoord(die);
            return IsInRange(die);
        }

        public Point ConvertToShiftCoord(Point die)
        {
            die.X -= ZeroDie.X;
            die.Y -= ZeroDie.Y;
            return die;
        }

        public Point ConvertToAbsoluteCoord(Point die)
        {
            die.X += ZeroDie.X;
            die.Y += ZeroDie.Y;
            return die;
        }

        public void SetDieStatus(Point die, DieStatus status)
        {
            if (IsInRange(die))
                switch (status)
                {
                    case DieStatus.OutOfWafer:
                    case DieStatus.UntestedDie:
                    case DieStatus.SkippedDie:
                    case DieStatus.TestedDie:
                            if (DieStsArr[die.X, die.Y] != DieStatus.OutOfWafer)
                                DieStsArr[die.X, die.Y] = status;
                            break;
                    case DieStatus.FirstDie:
                        FirstDie = die;
                        break;
                    case DieStatus.ZeroDie:
                        ZeroDie = die;
                        break;
                    case DieStatus.FirstZeroDie:
                        FirstDie = die;
                        ZeroDie = die;
                        break;
                }
        }

        public void SetDieStatus(int x, int y, DieStatus status)
        {
            SetDieStatus(new Point(x, y), status);
        }

        public DieStatus GetDieStatus(Point die)
        {
            DieStatus status = DieStatus.OutOfWafer;
            if (IsInRange(die))
            {
                if ((FirstDieXY == die) && (ZeroDieXY == die))
                    status = DieStatus.FirstZeroDie;
                else
                {
                    if (FirstDieXY == die)
                        status = DieStatus.FirstDie;
                    else
                    {
                        if (ZeroDieXY == die)
                            status = DieStatus.ZeroDie;
                        else
                            status = DieStsArr[die.X, die.Y];
                    }
                }
            }
            return status;
        }

        public DieStatus GetDieStatus(int x, int y)
        {
            return GetDieStatus(new Point(x, y));
        }

        public void SetDieArrStatus(DieStatus[,] dieStatusArr)
        {
            if ((dieStatusArr.GetLength(0) == WaferRange.Width) && (dieStatusArr.GetLength(1) == WaferRange.Height))
                for (int idxX = 0; idxX < WaferRange.Width; idxX++)
                    for (int idxY = 0; idxY < WaferRange.Height; idxY++)
                        SetDieStatus(idxX, idxY, dieStatusArr[idxX, idxY]);
        }

        public DieStatus[,] GetDieArrStatus()
        {
            DieStatus[,] dieStatusArr = new DieStatus[WaferRange.Width, WaferRange.Height];
            for (int idxX = 0; idxX < WaferRange.Width; idxX++)
                for (int idxY = 0; idxY < WaferRange.Height; idxY++)
                    dieStatusArr[idxX, idxY] = DieStsArr[idxX, idxY];
            return dieStatusArr;
        }

        public void SetDieTestStatus(Point die, DieStatus status)
        {
            switch (status)
            {
                case DieStatus.OutOfWafer:
                case DieStatus.UntestedDie:
                case DieStatus.SkippedDie:
                case DieStatus.TestedDie:
                    SetDieStatus(die, status);
                    break;
            }
        }

        public void SetDieTestStatus(int x, int y, DieStatus status)
        {
            SetDieTestStatus(new Point(x, y), status);
        }

        public DieStatus GetDieTestStatus(Point die)
        {
            DieStatus status = DieStatus.OutOfWafer;
            if (IsInRange(die))
                status = DieStsArr[die.X, die.Y];
            return status;
        }

        public DieStatus GetDieTestStatus(int x, int y)
        {
            return GetDieStatus(new Point(x, y));
        }

        public void SetDieBin(Point die, int bin)
        {
            if (IsInRange(die))
                DieBinArr[die.X, die.Y] = bin;
        }

        public void SetDieBin(int x, int y, int bin)
        {
            SetDieBin(new Point(x, y), bin);
        }

        public int GetDieBin(Point die)
        {
            int bin = 0;
            if (IsInRange(die))
                bin = DieBinArr[die.X, die.Y];
            return bin;
        }

        public int GetDieBin(int x, int y)
        {
            return GetDieBin(new Point(x, y));
        }

        public void SetDieArrBin(int[,] dieBinArr)
        {
            if ((dieBinArr.GetLength(0) == WaferRange.Width) && (dieBinArr.GetLength(1) == WaferRange.Height))
                for (int idxX = 0; idxX < WaferRange.Width; idxX++)
                    for (int idxY = 0; idxY < WaferRange.Height; idxY++)
                        SetDieBin(idxX, idxY, dieBinArr[idxX, idxY]);
        }

        public int[,] GetDieArrBin()
        {
            int[,] dieBinArr = new int[WaferRange.Width, WaferRange.Height];
            for (int idxX = 0; idxX < WaferRange.Width; idxX++)
                for (int idxY = 0; idxY < WaferRange.Height; idxY++)
                    dieBinArr[idxX, idxY] = DieBinArr[idxX, idxY];
            return dieBinArr;
        }
    }

    public enum DrawDieMode
    {
        WaferEditor, // for RowListCreator etc., it displays die status
        WaferViewer // for Mapper etc., it displays die bin values
    }

    public class DrawColor
    {
        public Color Background { get { return Color.FromKnownColor(KnownColor.Control); } }
        public Color WaferCircle { get { return Color.Black; } }
        public Color TempCircles { get { return Color.Lime; } }
        public Color WaferGrid { get { return Color.Gray; } }

        public Color OutOfWafer { get { return Color.White; } }
        public Color UntestedDie { get { return Color.Red; } }
        public Color SkippedDie { get { return Color.RoyalBlue; } }
        public Color TestedDie { get { return Color.Yellow; } }
        public Color FirstDie { get { return Color.Magenta; } }
        public Color ZeroDie { get { return Color.LimeGreen; } }
        public Color FirstZeroDie { get { return Color.Magenta; } }

        public Color GetBin(int bin)
        {
            // under construction
            Color binColor = Color.White;
            switch (bin)
            {
                case 1:
                    binColor = Color.RoyalBlue;
                    break;
            }
            return binColor;
        }
    }

    public class DrawWafer : WaferStatus
    {
        private DrawDieMode DrawingDieMode;
        private DrawColor DieColor;

        // Wafer's physical parameters
        private float WaferDiamMM; // [mm]
        private FlatPosition WaferFlatPos;
        private float DieWidthMM, DieHeightMM; // [mm]

        // Wafer's graphic variables
        private bool WasGraphVarCalculated;
        private Size CanvasSizePxls; // canvas size in pixels
        private Point DrawnLeftTopPxls; // left/top shift in pixels
        private int DrawnZoom; // drawing zoom
        private Size WaferSizePxls; // wafer size in pixels

        // Wafer's drawing variables - all in pixels
        private int[] DGridX, DGridY; // wafer grid in pixels
        private float DWaferDiam, DWaferStartX, DWaferStartY; // position and size of wafer
        private float DDieWidth, DDieHeight; // size of die
        private float DFlatStartAngle, DFlatEndAngle; // flat's angles for wafer circle
        private float DFlatStartX, DFlatStartY, DFlatEndX, DFlatEndY; // position for flat line
        private float[] DRingsDiam, DRingsX, DRingsY; // position and size of inside temporary rings

        public DrawWafer(DrawDieMode drawingDieMode,
            float waferDiam, FlatPosition flatPos, float dieWidth, float dieHeight)
            : base (GetDieXCnt(waferDiam, dieWidth), GetDieYCnt(waferDiam, dieHeight))
        {
            DieColor = new DrawColor();

            DrawingDieMode = drawingDieMode;
            WaferDiamMM = waferDiam;
            WaferFlatPos = flatPos;
            DieWidthMM = dieWidth;
            DieHeightMM = dieHeight;

            WasGraphVarCalculated = false;
            CanvasSizePxls = new Size(100, 100);
            DrawnLeftTopPxls = new Point(0, 0);
            DrawnZoom = 1;

            DefaultWaferStatus();
            CalculateDrawingVar();
        }

        private static int GetDieXCnt(float waferDiam, float dieWidth)
        {
            float dieX = ((waferDiam / 2) - (dieWidth / 2)) / dieWidth;
            return 2 * ((int)dieX + 1) + 1;
        }

        private static int GetDieYCnt(float waferDiam, float dieHeight)
        {
            float dieY = ((waferDiam / 2) - (dieHeight / 2)) / dieHeight;
            return 2 * ((int)dieY + 1) + 1;
        }

        private void CalculateDrawingVar()
        {
            if ((CanvasSizePxls.Width < 50) && (CanvasSizePxls.Height < 50))
                return;
            // calculate die size
            DWaferDiam = 19 * Math.Min(CanvasSizePxls.Width, CanvasSizePxls.Height) / 20;
            DWaferDiam *= DrawnZoom;
            DDieWidth = DWaferDiam * DieWidthMM / WaferDiamMM;
            DDieHeight = DWaferDiam * DieHeightMM / WaferDiamMM;
            // calculate grid line positions
            DGridX = new int[WaferRange.Width + 1]; // add one line to right side
            for (int idxX = 0; idxX <= WaferRange.Width; idxX++)
                DGridX[idxX] = (int)Math.Round(idxX * DDieWidth);
            DGridY = new int[WaferRange.Height + 1]; // add one line to bootm side
            for (int idxY = 0; idxY <= WaferRange.Height; idxY++)
                DGridY[idxY] = (int)Math.Round(idxY * DDieHeight);
            // store size of wafer
            WaferSizePxls = new Size(DGridX[DGridX.Length-1], DGridY[DGridY.Length-1]);

            // calculate position and diameter of wafer circles
            float gCenterX = (float)WaferSizePxls.Width / 2;
            float gCenterY = (float)WaferSizePxls.Height / 2;
            DWaferStartX = gCenterX - DWaferDiam / 2;
            DWaferStartY = gCenterY - DWaferDiam / 2;
            // calculate position of wafer flat
            float gFlatSin = DWaferDiam / 2 * (float)Math.Sin(Math.PI / 9); // 20 degrees
            float gFlatCos = DWaferDiam / 2 * (float)Math.Cos(Math.PI / 9); // 20 degrees
            switch (FlatPos)
            {
                case FlatPosition.Left:
                    DFlatStartX = gCenterX - gFlatCos;
                    DFlatStartY = gCenterY - gFlatSin;
                    DFlatEndX = gCenterX - gFlatCos;
                    DFlatEndY = gCenterY + gFlatSin;
                    DFlatStartAngle = 200;
                    DFlatEndAngle = 160;
                    break;
                case FlatPosition.Right:
                    DFlatStartX = gCenterX + gFlatCos;
                    DFlatStartY = gCenterY - gFlatSin;
                    DFlatEndX = gCenterX + gFlatCos;
                    DFlatEndY = gCenterY + gFlatSin;
                    DFlatStartAngle = 20;
                    DFlatEndAngle = 340;
                    break;
                case FlatPosition.Top:
                    DFlatStartX = gCenterX - gFlatSin;
                    DFlatStartY = gCenterY - gFlatCos;
                    DFlatEndX = gCenterX + gFlatSin;
                    DFlatEndY = gCenterY - gFlatCos;
                    DFlatStartAngle = 290;
                    DFlatEndAngle = 250;
                    break;
                case FlatPosition.Bottom:
                    DFlatStartX = gCenterX - gFlatSin;
                    DFlatStartY = gCenterY + gFlatCos;
                    DFlatEndX = gCenterX + gFlatSin;
                    DFlatEndY = gCenterY + gFlatCos;
                    DFlatStartAngle = 110;
                    DFlatEndAngle = 70;
                    break;
            }
            // calculate position and diameter of additional rings dislayed each 50mm
            DRingsDiam = new float[((int)WaferDiameter - 70) / 50];
            DRingsX = new float[DRingsDiam.Length];
            DRingsY = new float[DRingsDiam.Length];
            int ringDiam = 100;
            for (int idx = 0; idx < DRingsDiam.Length; idx++)
            {
                DRingsDiam[idx] = ringDiam * DWaferDiam / WaferDiamMM;
                DRingsX[idx] = gCenterX - DRingsDiam[idx] / 2;
                DRingsY[idx] = gCenterY - DRingsDiam[idx] / 2;
                ringDiam += 50;
            }

            WasGraphVarCalculated = true;
        }

        private void DefaultWaferStatus()
        {
            // calculate and initialize die status - test or out of wafer
            for (int idxX = 0; idxX < WaferRange.Width; idxX++)
                for (int idxY = 0; idxY < WaferRange.Height; idxY++)
                    DieStsArr[idxX, idxY] = DieStatus.OutOfWafer;
            for (int idxX = 0; idxX < ((WaferRange.Width / 2) + 1); idxX++)
                for (int idxY = 0; idxY < ((WaferRange.Height / 2) + 1); idxY++)
                {
                    float dist = (float)Math.Sqrt(
                        Math.Pow((WaferRange.Width / 2 - idxX) * DieWidthMM - DieWidthMM / 8, 2) +
                        Math.Pow((WaferRange.Height / 2 - idxY) * DieHeightMM - DieHeightMM / 8, 2));
                    if (dist < (WaferDiamMM / 2))
                    {
                        DieStsArr[idxX, idxY] = // 1.quadrant
                        DieStsArr[WaferRange.Width - idxX - 1, idxY] = // 2.quadrant
                        DieStsArr[idxX, WaferRange.Height - idxY - 1] = // 3.quadrant
                        DieStsArr[WaferRange.Width - idxX - 1, WaferRange.Height - idxY - 1] = // 4.quadrant
                            DieStatus.TestedDie;
                    }
                }
        }

        private bool IsXVisible(int x)
        {
            return (x >= 0) && (x < CanvasSizePxls.Width);
        }

        private bool IsYVisible(int y)
        {
            return (y >= 0) && (y < CanvasSizePxls.Height);
        }

        private bool IsPointVisible(Point point)
        {
            return IsXVisible(point.X) && IsYVisible(point.Y);
        }

        private bool IsXInWafer(int x)
        {
            if (CanvasSizePxls.Width > WaferSizePxls.Width)
            {
                int fromX = (CanvasSizePxls.Width / 2) - (WaferSizePxls.Width / 2);
                int toX = fromX + WaferSizePxls.Width;
                return (x >= fromX) && (x < toX);
            }
            else
                return IsXVisible(x);
        }

        private bool IsYInWaver(int y)
        {
            if (CanvasSizePxls.Height > WaferSizePxls.Height)
            {
                int fromY = (CanvasSizePxls.Height / 2) - (WaferSizePxls.Height / 2);
                int toY = fromY + WaferSizePxls.Height;
                return (y >= fromY) && (y < toY);
            }
            else
                return IsYVisible(y);
        }

        private bool IsPointInWafer(Point point)
        {
            return IsXInWafer(point.X) && IsYInWaver(point.Y);
        }

        private Color GetEditorDieColor(DieStatus status)
        {
            Color dieColor = DieColor.OutOfWafer;
            switch (status)
            {
                case DieStatus.UntestedDie:
                    dieColor = DieColor.UntestedDie;
                    break;
                case DieStatus.SkippedDie:
                    dieColor = DieColor.SkippedDie;
                    break;
                case DieStatus.TestedDie:
                    dieColor = DieColor.TestedDie;
                    break;
                case DieStatus.FirstDie:
                    dieColor = DieColor.FirstDie;
                    break;
                case DieStatus.ZeroDie:
                    dieColor = DieColor.ZeroDie;
                    break;
                case DieStatus.FirstZeroDie:
                    dieColor = DieColor.FirstZeroDie;
                    break;
            }
            return dieColor;
        }

        private void DrawGrid(Graphics canvas)
        {
            // calculate drawing temporary variables
            int fromX, fromY, toX, toY;
            if (CanvasSizePxls.Width > WaferSizePxls.Width)
            {
                fromX = (CanvasSizePxls.Width / 2) - (WaferSizePxls.Width / 2);
                toX = fromX + WaferSizePxls.Width;
            }
            else
            {
                fromX = 0;
                toX = CanvasSizePxls.Width;
            }
            if (CanvasSizePxls.Height > WaferSizePxls.Height)
            {
                fromY = (CanvasSizePxls.Height / 2) - (WaferSizePxls.Height / 2);
                toY = fromY + WaferSizePxls.Height;
            }
            else
            {
                fromY = 0;
                toY = CanvasSizePxls.Height;
            }
            // draw visible grid
            Pen pen = new Pen(DieColor.WaferGrid, 1);
            for (int idxX = 0; idxX <= WaferRange.Width; idxX++)
            {
                int lineX = fromX + DGridX[idxX] - LeftTop.X;
                if (IsXVisible(lineX))
                    canvas.DrawLine(pen, lineX, fromY, lineX, toY);
            }
            for (int idxY = 0; idxY <= WaferRange.Height; idxY++)
            {
                int lineY = fromY + DGridY[idxY] - LeftTop.Y;
                if (IsYVisible(lineY))
                canvas.DrawLine(pen, fromX, lineY, toX, lineY);
            }
        }

        private void DrawDie(Graphics canvas, Point die)
        {
            if (IsInRange(die))
            {
                int shiftX = -LeftTop.X, shiftY = -LeftTop.Y;
                if (CanvasSizePxls.Width > WaferSizePxls.Width)
                    shiftX = (CanvasSizePxls.Width / 2) - (WaferSizePxls.Width / 2);
                if (CanvasSizePxls.Height > WaferSizePxls.Height)
                    shiftY = (CanvasSizePxls.Height / 2) - (WaferSizePxls.Height / 2);
                int fromX = shiftX + DGridX[die.X] + 1;
                int fromY = shiftY + DGridY[die.Y] + 1;
                int toX = shiftX + DGridX[die.X + 1] - 1;
                int toY = shiftY + DGridY[die.Y + 1] - 1;
                if (IsXVisible(fromX) || IsXVisible(toX) || IsYVisible(fromY) || IsYVisible(toY))
                {
                    SolidBrush brush = new SolidBrush(DieColor.OutOfWafer);
                    switch (DrawingDieMode)
                    {
                        case DrawDieMode.WaferEditor:
                            brush.Color = GetEditorDieColor(GetDieStatus(die));
                            break;
                        case DrawDieMode.WaferViewer:
                            // under construction
                            brush.Color = DieColor.GetBin(GetDieBin(die));
                            break;
                    }
                    int deltaX = DGridX[die.X + 1] - DGridX[die.X] - 1;
                    int deltaY = DGridY[die.Y + 1] - DGridY[die.Y] - 1;
                    canvas.FillRectangle(brush, fromX, fromY, deltaX, deltaY);
                }
            }
        }

        private void DrawAllDies(Graphics canvas)
        {
            for (int idxX = 0; idxX < WaferRange.Width; idxX++)
                for (int idxY = 0; idxY < WaferRange.Height; idxY++)
                    DrawDie(canvas, new Point(idxX, idxY));
        }

        private void DrawWaferCircle(Graphics canvas)
        {
            int shiftX = -LeftTop.X, shiftY = -LeftTop.Y;
            if (CanvasSizePxls.Width > WaferSizePxls.Width)
                shiftX = (CanvasSizePxls.Width / 2) - (WaferSizePxls.Width / 2);
            if (CanvasSizePxls.Height > WaferSizePxls.Height)
                shiftY = (CanvasSizePxls.Height / 2) - (WaferSizePxls.Height / 2);
            Pen penB = new Pen(DieColor.WaferCircle, 1);
            Pen penG = new Pen(DieColor.TempCircles, 1);

            canvas.DrawArc(penB, shiftX + DWaferStartX, shiftY + DWaferStartY, 
                DWaferDiam, DWaferDiam, DFlatStartAngle, 320);
            canvas.DrawLine(penB, shiftX + DFlatStartX, shiftY + DFlatStartY, 
                shiftX + DFlatEndX, shiftY + DFlatEndY);
            canvas.DrawArc(penG, shiftX + DWaferStartX, shiftY + DWaferStartY, 
                DWaferDiam, DWaferDiam, DFlatEndAngle, 40);
            for (int idx = 0; idx < DRingsDiam.Length; idx++)
                canvas.DrawEllipse(penG, shiftX + DRingsX[idx], shiftY + DRingsY[idx], 
                    DRingsDiam[idx], DRingsDiam[idx]);
        }

        public float WaferDiameter
        {
            get { return WaferDiamMM; }
        }

        public float DieWith
        {
            get { return DieWidthMM; }
        }

        public float DieHeight
        {
            get { return DieHeightMM; }
        }

        public FlatPosition FlatPos
        {
            get { return WaferFlatPos; }
        }

        public Size WaferSize
        {
            get { return WaferSizePxls; }
        }

        public Size CanvasSize
        {
            set { CanvasSizePxls = value; WasGraphVarCalculated = false; CalculateDrawingVar(); }
            get { return CanvasSizePxls; }
        }

        public int Zoom
        {
            set { DrawnZoom = value; WasGraphVarCalculated = false; CalculateDrawingVar(); }
            get { return DrawnZoom; }
        }

        public Point LeftTop
        {
            set { DrawnLeftTopPxls = value; }
            get { return DrawnLeftTopPxls; }
        }

        public Point GetDieXYCoord(Point mouseXY)
        {
            Point die = new Point(1000000, 1000000);

            if (IsPointInWafer(mouseXY))
            {
                int shiftX, shiftY;
                if (CanvasSizePxls.Width > WaferSizePxls.Width)
                    shiftX = mouseXY.X - (CanvasSizePxls.Width / 2) + (WaferSizePxls.Width / 2);
                else
                    shiftX = mouseXY.X + LeftTop.X;
                if (CanvasSizePxls.Height > WaferSizePxls.Height)
                    shiftY = mouseXY.Y - (CanvasSizePxls.Height / 2) + (WaferSizePxls.Height / 2);
                else
                    shiftY = mouseXY.Y + LeftTop.Y;
                die.X = (int)(shiftX / DDieWidth);
                die.Y = (int)(shiftY / DDieHeight);
            }

            return die;
        }

        public Point GetDieShiftXYCoord(Point mouseXY)
        {
            Point die = GetDieXYCoord(mouseXY);
            if (IsInRange(die))
                die = ConvertToShiftCoord(die);
            return die;
        }

        public void ClearCanvas(Graphics canvas)
        {
            canvas.Clear(DieColor.Background);
        }

        public void Paint(Graphics canvas)
        {
            if ((canvas != null) && (WasGraphVarCalculated))
            {
                ClearCanvas(canvas);
                DrawGrid(canvas);
                DrawAllDies(canvas);
                DrawWaferCircle(canvas);
            }
        }

        public void PaintDie(Graphics canvas, Point die)
        {
            if ((canvas != null) && (WasGraphVarCalculated))
            {
                if (DrawingDieMode == DrawDieMode.WaferEditor)
                {
                    if ((GetDieStatus(die) == DieStatus.FirstZeroDie) ||
                        (GetDieStatus(die) == DieStatus.FirstDie) ||
                        (GetDieStatus(die) == DieStatus.ZeroDie))
                    {
                        DrawDie(canvas, LastFirstDie);
                        DrawDie(canvas, LastZeroDie);
                    }
                }
                DrawDie(canvas, die);
                if (DrawingDieMode == DrawDieMode.WaferEditor)
                    DrawWaferCircle(canvas);
            }
        }

        public void PaintDie(Graphics canvas, int x, int y)
        {
            PaintDie(canvas, new Point(x, y));
        }
    }
}
