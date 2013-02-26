namespace Ukoly
{
    partial class FormEditUkol
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
            this.dtpDatum = new System.Windows.Forms.DateTimePicker();
            this.lblDatum = new System.Windows.Forms.Label();
            this.cbDulezity = new System.Windows.Forms.CheckBox();
            this.cbUpozorneni = new System.Windows.Forms.CheckBox();
            this.tbUkol = new System.Windows.Forms.TextBox();
            this.lblUkol = new System.Windows.Forms.Label();
            this.btOk = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // dtpDatum
            // 
            this.dtpDatum.CustomFormat = "dd.MM.yyyy - HH:mm";
            this.dtpDatum.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpDatum.Location = new System.Drawing.Point(12, 25);
            this.dtpDatum.Name = "dtpDatum";
            this.dtpDatum.Size = new System.Drawing.Size(268, 20);
            this.dtpDatum.TabIndex = 0;
            // 
            // lblDatum
            // 
            this.lblDatum.AutoSize = true;
            this.lblDatum.Location = new System.Drawing.Point(12, 9);
            this.lblDatum.Name = "lblDatum";
            this.lblDatum.Size = new System.Drawing.Size(41, 13);
            this.lblDatum.TabIndex = 1;
            this.lblDatum.Text = "Datum:";
            // 
            // cbDulezity
            // 
            this.cbDulezity.AutoSize = true;
            this.cbDulezity.Location = new System.Drawing.Point(15, 51);
            this.cbDulezity.Name = "cbDulezity";
            this.cbDulezity.Size = new System.Drawing.Size(63, 17);
            this.cbDulezity.TabIndex = 2;
            this.cbDulezity.Text = "Dulezity";
            this.cbDulezity.UseVisualStyleBackColor = true;
            // 
            // cbUpozorneni
            // 
            this.cbUpozorneni.AutoSize = true;
            this.cbUpozorneni.Location = new System.Drawing.Point(15, 74);
            this.cbUpozorneni.Name = "cbUpozorneni";
            this.cbUpozorneni.Size = new System.Drawing.Size(80, 17);
            this.cbUpozorneni.TabIndex = 3;
            this.cbUpozorneni.Text = "Upozorneni";
            this.cbUpozorneni.UseVisualStyleBackColor = true;
            // 
            // tbUkol
            // 
            this.tbUkol.Location = new System.Drawing.Point(12, 110);
            this.tbUkol.Multiline = true;
            this.tbUkol.Name = "tbUkol";
            this.tbUkol.Size = new System.Drawing.Size(268, 144);
            this.tbUkol.TabIndex = 4;
            // 
            // lblUkol
            // 
            this.lblUkol.AutoSize = true;
            this.lblUkol.Location = new System.Drawing.Point(12, 94);
            this.lblUkol.Name = "lblUkol";
            this.lblUkol.Size = new System.Drawing.Size(32, 13);
            this.lblUkol.TabIndex = 5;
            this.lblUkol.Text = "Ukol:";
            // 
            // btOk
            // 
            this.btOk.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.btOk.Location = new System.Drawing.Point(68, 264);
            this.btOk.Name = "btOk";
            this.btOk.Size = new System.Drawing.Size(75, 23);
            this.btOk.TabIndex = 6;
            this.btOk.Text = "Ok";
            this.btOk.UseVisualStyleBackColor = true;
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(149, 264);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 7;
            this.btnCancel.Text = "Storno";
            this.btnCancel.UseVisualStyleBackColor = true;
            // 
            // FormEditUkol
            // 
            this.AcceptButton = this.btOk;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.btnCancel;
            this.ClientSize = new System.Drawing.Size(292, 299);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btOk);
            this.Controls.Add(this.lblUkol);
            this.Controls.Add(this.tbUkol);
            this.Controls.Add(this.cbUpozorneni);
            this.Controls.Add(this.cbDulezity);
            this.Controls.Add(this.lblDatum);
            this.Controls.Add(this.dtpDatum);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "FormEditUkol";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Vlastnosti ukolu";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblDatum;
        private System.Windows.Forms.Label lblUkol;
        private System.Windows.Forms.Button btOk;
        private System.Windows.Forms.Button btnCancel;
        public System.Windows.Forms.DateTimePicker dtpDatum;
        public System.Windows.Forms.CheckBox cbDulezity;
        public System.Windows.Forms.CheckBox cbUpozorneni;
        public System.Windows.Forms.TextBox tbUkol;
    }
}