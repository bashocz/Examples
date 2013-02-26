using System;
using System.Collections.ObjectModel;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Input;

namespace Plochy
{
    public partial class MainPage : UserControl
    {
        private readonly Mesh grid = Templates.GetGrid();
        private readonly Mesh axis = Templates.GetAxis();

        // viewing of scene
        private DrawingBitmap draw3DProjection;

        // drawing object
        private Surface surface;

        public MainPage()
        {
            InitializeComponent();

            Loaded += MainPage_Loaded;

            DrawContainer.SizeChanged += DrawContainer_SizeChanged;

            ImgDraw3DProjection.MouseEnter += ImgDraw3DProjection_MouseEnter;
            ImgDraw3DProjection.MouseLeave += ImgDraw3DProjection_MouseLeave;
            ImgDraw3DProjection.MouseMove += ImgDraw3DProjection_MouseMove;
            ImgDraw3DProjection.MouseLeftButtonDown += ImgDraw3DProjection_MouseLeftButtonDown;
            ImgDraw3DProjection.MouseLeftButtonUp += ImgDraw3DProjection_MouseLeftButtonUp;
            ImgDraw3DProjection.MouseWheel += ImgDraw3DProjection_MouseWheel;

            Cb3D.Checked += Cb3D_Checked;
            Cb3D.Unchecked += Cb3D_Unchecked;

            BtnDefault.Click += BtnDefault_Click;

            RbBezier.Checked += RbBezier_Checked;
            RbCoonsBspline.Checked += RbCoonsBspline_Checked;

            TbSoftness.KeyUp += TbSoftness_KeyUp;
            BtnExample1.Click += BtnExample1_Click;
            BtnExample2.Click += BtnExample2_Click;
            BtnExample3.Click += BtnExample3_Click;
            BtnExample4.Click += BtnExample4_Click;
            BtnExample5.Click += BtnExample5_Click;
            BtnExample6.Click += BtnExample6_Click;
            BtnExample7.Click += BtnExample7_Click;
            BtnExample8.Click += BtnExample8_Click;
        }

        private void MainPage_Loaded(object sender, System.Windows.RoutedEventArgs e)
        {
            draw3DProjection = new DrawingBitmap(DrawingType.drawing3D, null, axis, grid);

            StackOption.DataContext = draw3DProjection;

            RbCoonsBspline.IsChecked = true;

            CreateTemplate(3);
        }

        private void DrawContainer_SizeChanged(object sender, System.Windows.SizeChangedEventArgs e)
        {
            InitDraw();
            Draw();
        }

        private void ImgDraw3DProjection_MouseEnter(object sender, System.Windows.Input.MouseEventArgs e)
        {
            ImgDraw3DProjection.CaptureMouse();
        }

        private void ImgDraw3DProjection_MouseLeave(object sender, System.Windows.Input.MouseEventArgs e)
        {
            ImgDraw3DProjection.ReleaseMouseCapture();
            draw3DProjection.MouseUp();
        }

        private void ImgDraw3DProjection_MouseMove(object sender, System.Windows.Input.MouseEventArgs e)
        {
            draw3DProjection.MouseMove(e.GetPosition(ImgDraw3DProjection));
        }

        private void ImgDraw3DProjection_MouseLeftButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            draw3DProjection.MouseDown(e.GetPosition(ImgDraw3DProjection));
        }

        private void ImgDraw3DProjection_MouseLeftButtonUp(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            draw3DProjection.MouseUp();
        }

        private void ImgDraw3DProjection_MouseWheel(object sender, System.Windows.Input.MouseWheelEventArgs e)
        {
            e.Handled = true;
            if (e.Delta > 0)
            {
                draw3DProjection.ZoomIndex++;
            }
            else
            {
                draw3DProjection.ZoomIndex--;
            }
        }

        private void BtnDefault_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            draw3DProjection.Default();
        }

        private void Cb3D_Checked(object sender, System.Windows.RoutedEventArgs e)
        {
            DrawContainer.ColumnDefinitions[1].Width = new GridLength(0, GridUnitType.Star);
            DrawContainer.RowDefinitions[1].Height = new GridLength(0, GridUnitType.Star);
            DrawContainer.UpdateLayout();
            InitDraw();
        }

        private void Cb3D_Unchecked(object sender, System.Windows.RoutedEventArgs e)
        {
            DrawContainer.ColumnDefinitions[1].Width = new GridLength(1, GridUnitType.Star);
            DrawContainer.RowDefinitions[1].Height = new GridLength(1, GridUnitType.Star);
            DrawContainer.UpdateLayout();
            InitDraw();
        }

        private void RbBezier_Checked(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(0);
        }

        private void RbCoonsBspline_Checked(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(0);
        }

        private void TbSoftness_KeyUp(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                e.Handled = true;
                TbSoftness.GetBindingExpression(TextBox.TextProperty).UpdateSource();
            }
        }

        private void BtnExample1_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(1);
        }

        private void BtnExample2_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(2);
        }

        private void BtnExample3_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(3);
        }

        private void BtnExample4_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(4);
        }

        private void BtnExample5_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(5);
        }

        private void BtnExample6_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(6);
        }

        private void BtnExample7_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(7);
        }

        private void BtnExample8_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            CreateTemplate(8);
        }

        private void Rendering(object sender, EventArgs e)
        {
            Draw();
        }

        private void InitDraw()
        {
            // Show fps counter in IE only
            Application.Current.Host.Settings.EnableFrameRateCounter = true;

            // Init WriteableBitmap
            draw3DProjection.Bmp = new WriteableBitmap((int)DrawContainer.ColumnDefinitions[0].ActualWidth,
                (int)DrawContainer.RowDefinitions[0].ActualHeight);
            ImgDraw3DProjection.Source = draw3DProjection.Bmp;

            // Start render loop
            CompositionTarget.Rendering += new EventHandler(Rendering);
        }

        private void Draw()
        {
            if (draw3DProjection != null)
                draw3DProjection.Draw();
        }

        private void CreateTemplate(int templateIndex)
        {
            if ((templateIndex > 0) || (surface == null))
            {
                if (RbBezier.IsChecked == true)
                    surface = Templates.GetBezier(templateIndex);
                else
                    surface = Templates.GetCoons(templateIndex);
            }
            else
            {
                if (RbBezier.IsChecked == true)
                    surface = Templates.GetBezier(surface);
                else
                    surface = Templates.GetCoons(surface);
            }

            draw3DProjection.Mesh = surface;
            StackFace.DataContext = surface;
        }
    }
}
