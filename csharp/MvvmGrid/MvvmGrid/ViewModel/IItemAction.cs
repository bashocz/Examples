using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MvvmGrid.ViewModel
{
    interface IItemAction
    {
        void DeleteItem(GridItemViewModel item);
    }
}
