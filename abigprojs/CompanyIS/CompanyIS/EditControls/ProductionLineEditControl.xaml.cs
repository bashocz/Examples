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

namespace Basho
{
    /// <summary>
    /// Interaction logic for ProductionLineEditControl.xaml
    /// </summary>
    public partial class ProductionLineEditControl : UserControl
    {
        private IDataConnection data;

        private ProductionLine lineBackup;
        private ProductionLine line;

        public ProductionLineEditControl()
        {
            InitializeComponent();

            btnSave.Click += new RoutedEventHandler(btnSave_Click);
            btnCancel.Click += new RoutedEventHandler(btnCancel_Click);
        }

        private void btnSave_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                if (lineBackup == null)
                {
                    lineBackup = data.NewProductionLine(line.Name, line.Capacity, line.Efficiency);
                    line.Id = lineBackup.Id;
                }
                else
                {
                    data.UpdateProductionLine(line, lineBackup);
                    lineBackup.Name = line.Name;
                    lineBackup.Capacity = line.Capacity;
                    lineBackup.Efficiency = line.Efficiency;
                    lineBackup.Active = line.Active;
                }
            }
            catch { }
        }

        private void btnCancel_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            EditLine(lineBackup);
        }

        private void EditLine(ProductionLine editLine)
        {
            line = new ProductionLine();
            if (editLine != null)
            {
                line.Id = editLine.Id;
                line.Name = editLine.Name;
                line.Capacity = editLine.Capacity;
                line.Efficiency = editLine.Efficiency;
                line.Active = editLine.Active;
            }
            gridEdit.DataContext = line;
        }

        public IDataConnection Data
        {
            set { data = value; }
        }

        public ProductionLine Line
        {
            set
            {
                lineBackup = value;
                EditLine(value);
            }
        }
    }
}
