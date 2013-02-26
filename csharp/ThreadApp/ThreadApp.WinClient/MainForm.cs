using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Basho.ThreadApp
{
    public partial class MainForm : Form
    {
        private const string sourcePath = @"D:\tmp\source";
        private const string destPath = @"D:\tmp\dest";

        private FileCopyActivity activity;

        public MainForm()
        {
            InitializeComponent();
        }

        private void copyButton_Click(object sender, EventArgs e)
        {
            activity = new FileCopyActivity(sourcePath, destPath);
            activity.ProgressChanged += new EventHandler(ActivityProgressChanged);
            activity.Start();
        }

        private void ChangeProgresBar(int progress)
        {
            progressBar.Value = progress;
        }

        void ActivityProgressChanged(object sender, EventArgs e)
        {
            base.BeginInvoke(new ChangeProgressBarDelegate(ChangeProgresBar), activity.Progress);
        }

        delegate void ChangeProgressBarDelegate(int progress);
    }
}