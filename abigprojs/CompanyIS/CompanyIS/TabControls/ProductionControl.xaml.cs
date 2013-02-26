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
    /// Interaction logic for ProductionControl.xaml
    /// </summary>
    public partial class ProductionControl : UserControl
    {
        private IDataConnection data;

        private List<ProductionLine> lineList;

        private RecordInfo lineRecords = new RecordInfo { Start = 1, Count = 10 };

        public ProductionControl()
        {
            InitializeComponent();

            IsVisibleChanged += new DependencyPropertyChangedEventHandler(ProductionControl_IsVisibleChanged);

            btnUpdate.Click += new RoutedEventHandler(btnUpdate_Click);

            pnlProductionLineRecords.DataContext = lineRecords;
            pnlProductionRecords.DataContext = lineRecords;
        }

        private void ProductionControl_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                tabs.SelectedIndex = 0;
                GetProductionLineList();
            }
        }

        private void btnUpdate_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            GetProductionLineList();
        }

        private void btnStart_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                ProductionLine line = (sender as Button).DataContext as ProductionLine;
                Plan plan = data.ProductionStart(line);
                line.Plan = plan;
                if (plan != null)
                    line.Status = Status.Working;
                else
                    line.Status = Status.NoPlan;
            }
            catch { }
        }

        private void btnEnd_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                ProductionLine line = (sender as Button).DataContext as ProductionLine;
                data.ProductionEnd(line);
                line.Plan = data.GetProductionLinePlan(line);
                line.Status = Status.NoWorking;
            }
            catch { }
        }

        private void tbProductionLineCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                lineRecords.Start = 1;
                GetProductionLineList();
                e.Handled = true;
            }
        }

        private void btnProductionLinePrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            lineRecords.Start -= lineRecords.Count;
            GetProductionLineList();
        }

        private void btnProductionLineNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            lineRecords.Start += lineRecords.Count;
            GetProductionLineList();
        }

        private void tbProductionCount_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                lineRecords.Start = 1;
                GetProductionLineList();
                e.Handled = true;
            }
        }

        private void btnProductionPrev_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            lineRecords.Start -= lineRecords.Count;
            GetProductionLineList();
        }

        private void btnProductionNext_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            lineRecords.Start += lineRecords.Count;
            GetProductionLineList();
        }

        private void btnNew_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                string lineName = "Výrobní linka";
                int idx = 0;
                bool exist = true;
                while (exist)
                {
                    exist = false;
                    foreach(ProductionLine line in lineList)
                        if (string.Compare(line.Name, lineName, true) == 0)
                        {
                            exist = true;
                            break;
                        }
                    if (exist)
                    {
                        idx++;
                        lineName = "Výrobní linka " + idx.ToString("00");
                    }
                }

                ProductionLine newLine = data.NewProductionLine(lineName, 1, 1);

                lineList.Add(newLine);

                lbProduction.ItemsSource = null;
                lbProduction.ItemsSource = lineList;

                lbProductionEdit.ItemsSource = null;
                lbProductionEdit.ItemsSource = lineList;
            }
            catch { }
        }

        private void lbProductionEdit_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            ctrlEditProductionLine.Line = lbProductionEdit.SelectedItem as ProductionLine;
        }

        private void GetProductionLineList()
        {
            try
            {
                lbProduction.ItemsSource = null;
                lbProductionEdit.ItemsSource = null;

                lineList = data.GetProductionLines(lineRecords);
                foreach (ProductionLine line in lineList)
                {
                    if ((bool)line.IsActive)
                    {
                        Plan plan = data.GetProductionLinePlan(line);
                        line.Plan = plan;
                        if ((plan != null) && (string.Compare(plan.State, "Vyrabi se", true) == 0))
                            line.Status = Status.Working;
                        else
                            line.Status = Status.NoWorking;
                    }
                    else
                        lineList.Remove(line);
                }

                lbProduction.ItemsSource = lineList;
                lbProductionEdit.ItemsSource = lineList;
            }
            catch { }
        }

        public IDataConnection Data
        {
            set
            {
                data = value;
                ctrlEditProductionLine.Data = value;
            }
        }
    }
}
