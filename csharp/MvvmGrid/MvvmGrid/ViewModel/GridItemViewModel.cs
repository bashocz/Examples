using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Media;
using System.Windows.Input;

namespace MvvmGrid.ViewModel
{
    class GridItemViewModel : BaseViewModel
    {
        private IItemAction actions;

        private ICommand deleteCommand;

        public GridItemViewModel(IItemAction actions)
        {
            this.actions = actions;
        }

        private int col;
        public int Col
        {
            get { return col; }
            set
            {
                if (col != value)
                {
                    col = value;
                    NotifyPropertyChanged("Col");
                }
            }
        }

        private int colSpan;
        public int ColSpan
        {
            get { return colSpan; }
            set
            {
                if (colSpan != value)
                {
                    colSpan = value;
                    NotifyPropertyChanged("ColSpan");
                }
            }
        }

        private int row;
        public int Row
        {
            get { return row; }
            set
            {
                if (row != value)
                {
                    row = value;
                    NotifyPropertyChanged("Row");
                }
            }
        }

        private int rowSpan;
        public int RowSpan
        {
            get { return rowSpan; }
            set
            {
                if (rowSpan != value)
                {
                    rowSpan = value;
                    NotifyPropertyChanged("RowSpan");
                }
            }
        }

        private void Delete()
        {
            actions.DeleteItem(this);
        }

        public ICommand DeleteCommand
        {
            get
            {
                if (deleteCommand == null)
                    deleteCommand = new BaseCommand(param => Delete());
                return deleteCommand;
            }
        }
    }
}
