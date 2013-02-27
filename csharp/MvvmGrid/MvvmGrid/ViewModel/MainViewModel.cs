using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.ObjectModel;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows;

namespace MvvmGrid.ViewModel
{
    class MainViewModel : BaseViewModel, IItemAction
    {
        private readonly Random random = new Random();

        private ICommand newRectCommand;
        private readonly ObservableCollection<GridItemViewModel> items = new ObservableCollection<GridItemViewModel>();

        public MainViewModel()
        {
        }

        private bool AreIntersected(int colA, int rowA, int colSpanA, int rowSpanA, int colB, int rowB, int colSpanB, int rowSpanB)
        {
            if ((colA + colSpanA - 1) < colB)
                return false;
            if ((colB + colSpanB - 1) < colA)
                return false;
            if ((rowA + rowSpanA - 1) < rowB)
                return false;
            if ((rowB + rowSpanB - 1) < rowA)
                return false;
            return true;
        }

        private bool EmptyCells(int col, int colSpan, int row, int rowSpan)
        {
            foreach (GridItemViewModel item in items)
                if (AreIntersected(col, row, colSpan, rowSpan, item.Col, item.Row, item.ColSpan, item.RowSpan))
                    return false;
            return true;
        }

        private void Arrange(GridItemViewModel item)
        {
            int col;
            int row;
            int colSpan;
            int rowSpan = 1;
            do
            {
                col = random.Next(5);
                colSpan = random.Next(4 - col) + 1;
                row = random.Next(5);
            } while (!EmptyCells(col, colSpan, row, rowSpan));
            item.Col = col;
            item.ColSpan = colSpan;
            item.Row = row;
            item.RowSpan = rowSpan;
        }

        private Color GetColor()
        {
            return Color.FromRgb((byte)random.Next(256), (byte)random.Next(256), (byte)random.Next(256));
        }

        private GridItemViewModel NewRectangle()
        {
            RectangleViewModel rect = new RectangleViewModel(this);
            rect.Color = GetColor();
            Arrange(rect);
            return rect;
        }

        private GridItemViewModel NewEllipse()
        {
            EllipseViewModel ellipse = new EllipseViewModel(this);
            ellipse.Color = GetColor();
            Arrange(ellipse);
            return ellipse;
        }

        private void NewItem()
        {
            if (random.Next(2) > 0)
                items.Add(NewRectangle());
            else
                items.Add(NewEllipse());
        }

        private bool CanNewItem
        {
            get { return items.Count < 10; }
        }

        public ICommand NewRectCommand
        {
            get
            {
                if (newRectCommand == null)
                    newRectCommand = new BaseCommand(param => NewItem(), param => CanNewItem);
                return newRectCommand;
            }
        }

        public ObservableCollection<GridItemViewModel> Items
        {
            get { return items; }
        }

        #region IItemAction Members

        public void DeleteItem(GridItemViewModel item)
        {
            items.Remove(item);
        }

        #endregion
    }
}
