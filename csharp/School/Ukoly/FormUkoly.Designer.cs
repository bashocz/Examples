namespace Ukoly
{
    partial class FormUkoly
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle9 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle12 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle10 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle11 = new System.Windows.Forms.DataGridViewCellStyle();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.tlpUkoly = new System.Windows.Forms.TableLayoutPanel();
            this.dgUkoly = new System.Windows.Forms.DataGridView();
            this.pnlButtons = new System.Windows.Forms.Panel();
            this.btnNovy = new System.Windows.Forms.Button();
            this.BtnEdit = new System.Windows.Forms.Button();
            this.btnSmaz = new System.Windows.Forms.Button();
            this.dgcDatum = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgcDulezite = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgcUpozorneni = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgcText = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dgcUkol = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.tlpUkoly.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgUkoly)).BeginInit();
            this.pnlButtons.SuspendLayout();
            this.SuspendLayout();
            // 
            // timer
            // 
            this.timer.Enabled = true;
            this.timer.Interval = 1000;
            this.timer.Tick += new System.EventHandler(this.timer_Tick);
            // 
            // tlpUkoly
            // 
            this.tlpUkoly.ColumnCount = 3;
            this.tlpUkoly.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 8F));
            this.tlpUkoly.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpUkoly.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 8F));
            this.tlpUkoly.Controls.Add(this.dgUkoly, 1, 1);
            this.tlpUkoly.Controls.Add(this.pnlButtons, 1, 3);
            this.tlpUkoly.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tlpUkoly.Location = new System.Drawing.Point(0, 0);
            this.tlpUkoly.Name = "tlpUkoly";
            this.tlpUkoly.RowCount = 5;
            this.tlpUkoly.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 8F));
            this.tlpUkoly.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tlpUkoly.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 8F));
            this.tlpUkoly.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 32F));
            this.tlpUkoly.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 8F));
            this.tlpUkoly.Size = new System.Drawing.Size(616, 450);
            this.tlpUkoly.TabIndex = 0;
            // 
            // dgUkoly
            // 
            this.dgUkoly.AllowUserToAddRows = false;
            this.dgUkoly.AllowUserToDeleteRows = false;
            this.dgUkoly.AllowUserToResizeColumns = false;
            this.dgUkoly.AllowUserToResizeRows = false;
            this.dgUkoly.BackgroundColor = System.Drawing.SystemColors.Control;
            this.dgUkoly.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle9.Alignment = System.Windows.Forms.DataGridViewContentAlignment.TopCenter;
            dataGridViewCellStyle9.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle9.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            dataGridViewCellStyle9.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle9.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle9.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle9.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgUkoly.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle9;
            this.dgUkoly.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgUkoly.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dgcDatum,
            this.dgcDulezite,
            this.dgcUpozorneni,
            this.dgcText,
            this.dgcUkol});
            this.dgUkoly.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgUkoly.Location = new System.Drawing.Point(11, 11);
            this.dgUkoly.Name = "dgUkoly";
            dataGridViewCellStyle12.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle12.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle12.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            dataGridViewCellStyle12.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle12.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle12.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle12.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgUkoly.RowHeadersDefaultCellStyle = dataGridViewCellStyle12;
            this.dgUkoly.RowHeadersVisible = false;
            this.dgUkoly.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.dgUkoly.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgUkoly.ShowCellErrors = false;
            this.dgUkoly.ShowCellToolTips = false;
            this.dgUkoly.ShowEditingIcon = false;
            this.dgUkoly.ShowRowErrors = false;
            this.dgUkoly.Size = new System.Drawing.Size(594, 388);
            this.dgUkoly.TabIndex = 0;
            this.dgUkoly.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgUkoly_CellDoubleClick);
            // 
            // pnlButtons
            // 
            this.pnlButtons.Controls.Add(this.btnSmaz);
            this.pnlButtons.Controls.Add(this.BtnEdit);
            this.pnlButtons.Controls.Add(this.btnNovy);
            this.pnlButtons.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlButtons.Location = new System.Drawing.Point(11, 413);
            this.pnlButtons.Name = "pnlButtons";
            this.pnlButtons.Size = new System.Drawing.Size(594, 26);
            this.pnlButtons.TabIndex = 1;
            // 
            // btnNovy
            // 
            this.btnNovy.Location = new System.Drawing.Point(179, 2);
            this.btnNovy.Name = "btnNovy";
            this.btnNovy.Size = new System.Drawing.Size(75, 23);
            this.btnNovy.TabIndex = 0;
            this.btnNovy.Text = "Novy ukol";
            this.btnNovy.UseVisualStyleBackColor = true;
            this.btnNovy.Click += new System.EventHandler(this.btnNovy_Click);
            // 
            // BtnEdit
            // 
            this.BtnEdit.Location = new System.Drawing.Point(260, 2);
            this.BtnEdit.Name = "BtnEdit";
            this.BtnEdit.Size = new System.Drawing.Size(75, 23);
            this.BtnEdit.TabIndex = 1;
            this.BtnEdit.Text = "Edituj ukol";
            this.BtnEdit.UseVisualStyleBackColor = true;
            this.BtnEdit.Click += new System.EventHandler(this.BtnEdit_Click);
            // 
            // btnSmaz
            // 
            this.btnSmaz.Location = new System.Drawing.Point(341, 2);
            this.btnSmaz.Name = "btnSmaz";
            this.btnSmaz.Size = new System.Drawing.Size(75, 23);
            this.btnSmaz.TabIndex = 2;
            this.btnSmaz.Text = "Smaz ukol";
            this.btnSmaz.UseVisualStyleBackColor = true;
            this.btnSmaz.Click += new System.EventHandler(this.btnSmaz_Click);
            // 
            // dgcDatum
            // 
            this.dgcDatum.HeaderText = "Datum";
            this.dgcDatum.Name = "dgcDatum";
            this.dgcDatum.ReadOnly = true;
            this.dgcDatum.Resizable = System.Windows.Forms.DataGridViewTriState.False;
            // 
            // dgcDulezite
            // 
            dataGridViewCellStyle10.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle10.ForeColor = System.Drawing.Color.Red;
            this.dgcDulezite.DefaultCellStyle = dataGridViewCellStyle10;
            this.dgcDulezite.HeaderText = "!";
            this.dgcDulezite.Name = "dgcDulezite";
            this.dgcDulezite.ReadOnly = true;
            this.dgcDulezite.Resizable = System.Windows.Forms.DataGridViewTriState.False;
            this.dgcDulezite.Width = 16;
            // 
            // dgcUpozorneni
            // 
            dataGridViewCellStyle11.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            this.dgcUpozorneni.DefaultCellStyle = dataGridViewCellStyle11;
            this.dgcUpozorneni.HeaderText = "A";
            this.dgcUpozorneni.Name = "dgcUpozorneni";
            this.dgcUpozorneni.ReadOnly = true;
            this.dgcUpozorneni.Resizable = System.Windows.Forms.DataGridViewTriState.False;
            this.dgcUpozorneni.Width = 16;
            // 
            // dgcText
            // 
            this.dgcText.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.dgcText.HeaderText = "Text";
            this.dgcText.Name = "dgcText";
            this.dgcText.ReadOnly = true;
            this.dgcText.Resizable = System.Windows.Forms.DataGridViewTriState.False;
            // 
            // dgcUkol
            // 
            this.dgcUkol.HeaderText = "";
            this.dgcUkol.Name = "dgcUkol";
            this.dgcUkol.ReadOnly = true;
            this.dgcUkol.Visible = false;
            // 
            // FormUkoly
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(616, 450);
            this.Controls.Add(this.tlpUkoly);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "FormUkoly";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Ukoly";
            this.Load += new System.EventHandler(this.FormUkoly_Load);
            this.tlpUkoly.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgUkoly)).EndInit();
            this.pnlButtons.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Timer timer;
        private System.Windows.Forms.TableLayoutPanel tlpUkoly;
        private System.Windows.Forms.DataGridView dgUkoly;
        private System.Windows.Forms.Panel pnlButtons;
        private System.Windows.Forms.Button btnSmaz;
        private System.Windows.Forms.Button BtnEdit;
        private System.Windows.Forms.Button btnNovy;
        private System.Windows.Forms.DataGridViewTextBoxColumn dgcDatum;
        private System.Windows.Forms.DataGridViewTextBoxColumn dgcDulezite;
        private System.Windows.Forms.DataGridViewTextBoxColumn dgcUpozorneni;
        private System.Windows.Forms.DataGridViewTextBoxColumn dgcText;
        private System.Windows.Forms.DataGridViewTextBoxColumn dgcUkol;
    }
}

