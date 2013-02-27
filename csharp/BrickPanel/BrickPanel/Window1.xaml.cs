using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BrickPanel
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        class Brick
        {
            public Brick(int column, int span)
            {
                Column = column;
                Span = span;
                Row = -1;
            }

            public int Column { get; private set; }
            public int Span { get; private set; }
            public int Row { get; set; }
        }

        public Window1()
        {
            InitializeComponent();

            List<Brick> bricks = GetBrickList();
            ArrangeBrick(bricks);
            ShowBrick(spWeek, bricks);
        }

        private List<Brick> GetBrickList()
        {
            List<Brick> bricks = new List<Brick>();
            bricks.Add(new Brick(0, 4));
            bricks.Add(new Brick(1, 3));
            bricks.Add(new Brick(0, 2));
            bricks.Add(new Brick(1, 2));
            bricks.Add(new Brick(2, 2));
            bricks.Add(new Brick(0, 1));
            bricks.Add(new Brick(0, 1));
            bricks.Add(new Brick(0, 1));
            bricks.Add(new Brick(1, 1));
            bricks.Add(new Brick(2, 1));
            bricks.Add(new Brick(2, 1));
            bricks.Add(new Brick(3, 1));
            bricks.Add(new Brick(3, 1));
            bricks.Add(new Brick(3, 1));
            return bricks;
        }

        private void ArrangeBrick(List<Brick> bricks)
        {
            List<int[]> wall = new List<int[]>();

            foreach (Brick brick in bricks)
            {
                int rowIdx = 0;
                foreach (int[] row in wall)
                {
                    bool free = true;
                    for (int col = brick.Column; col < (brick.Column + brick.Span); col++)
                        if (row[col] > 0)
                        {
                            free = false;
                            break;
                        }
                    if (free)
                    {
                        brick.Row = rowIdx;
                        break;
                    }
                    rowIdx++;
                }
                if (brick.Row < 0)
                {
                    wall.Add(new int[4]);
                    brick.Row = wall.Count - 1;
                }
                if (rowIdx < wall.Count)
                {
                    for (int col = brick.Column; col < (brick.Column + brick.Span); col++)
                        wall[rowIdx][col] = 1;
                }
                else
                    throw new Exception("ALGORITHM ERROR...");
            }
        }

        private void ShowBrick(StackPanel panel, List<Brick> bricks)
        {
            panel.Children.Clear();

            int brickIndex = 0;

            List<Grid> grids = new List<Grid>();
            foreach (Brick brick in bricks)
            {
                brickIndex++;
                while (grids.Count < (brick.Row + 1))
                {
                    Grid grid = new Grid();
                    for (int idx = 0; idx < 4; idx++)
                        grid.ColumnDefinitions.Add(new ColumnDefinition());
                    grid.Height = 50;
                    grid.Background = new SolidColorBrush(Colors.Lime);

                    MultiBinding multiBinding = new MultiBinding();
                    multiBinding.Converter = new BrickVisibleConverter();
                    multiBinding.ConverterParameter = grids.Count + 1;

                    Binding binding = new Binding();
                    binding.Source = panel;
                    binding.Path = new PropertyPath(FrameworkElement.ActualHeightProperty);
                    multiBinding.Bindings.Add(binding);

                    binding = new Binding();
                    binding.Source = grid;
                    binding.Path = new PropertyPath(FrameworkElement.ActualHeightProperty);
                    multiBinding.Bindings.Add(binding);

                    grid.SetBinding(Grid.VisibilityProperty, multiBinding);

                    grids.Add(grid);
                    panel.Children.Add(grid);
                }

                Border border = new Border();
                border.Background = new SolidColorBrush(Colors.Blue);
                border.Margin = new Thickness(5);
                Grid.SetColumn(border, brick.Column);
                Grid.SetColumnSpan(border, brick.Span);

                TextBlock text = new TextBlock();
                text.Text = brickIndex.ToString();

                border.Child = text;

                grids[brick.Row].Children.Add(border);
            }
        }
    }
}
