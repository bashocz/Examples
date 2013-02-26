using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Basho.FloatNumber
{
    public partial class FrmMain : Form
    {
        private readonly int mantisa = 10;
        private readonly int exponent = 6;
        private readonly double step;

        private Random random;
        private FloatNumber numberA;
        private FloatNumber numberB;
        private FloatNumber numberApB;
        private FloatNumber numberAmB;
        private FloatNumber numberBmA;
        private FloatNumber numberAxB;
        private FloatNumber numberAdB;
        private FloatNumber numberBdA;

        public FrmMain()
        {
            InitializeComponent();

            step = Math.Pow(2, -mantisa);

            random = new Random(666);

            numberA = GetNumber(111.111);
            numberB = GetNumber(-1.23456);
            numberApB =
            numberAmB =
            numberBmA =
            numberAxB =
            numberAdB =
            numberBdA = null;

            ShowAll();
        }

        private FloatNumber GetNumber(double number)
        {
            return new FloatNumber(number, mantisa, exponent);
        }

        private void ShowN(FloatNumber number, TextBox n10, TextBox nB, TextBox n2, TextBox nR)
        {
            if (n10 != null)
                n10.Text = (number != null) ? number.StrNumber10 : string.Empty;
            if (nB != null)
                nB.Text = (number != null) ? number.StrBinary : string.Empty;
            if (n2 != null)
                n2.Text = (number != null) ? number.StrNumber2 : string.Empty;
            if (nR != null)
                nR.Text = (number != null) ? number.StrNumberR : string.Empty;
        }

        private void ShowA()
        {
            ShowN(numberA, tbA10, tbAB, tbA2, tbAR);
        }

        private void ShowB()
        {
            ShowN(numberB, tbB10, tbBB, tbB2, tbBR);
        }

        private void ShowApB()
        {
            ShowN(numberApB, null, tbApBB, tbApB2, tbApBR);
        }

        private void ShowAmB()
        {
            ShowN(numberAmB, null, tbAmBB, tbAmB2, tbAmBR);
        }

        private void ShowBmA()
        {
            ShowN(numberBmA, null, tbBmAB, tbBmA2, tbBmAR);
        }

        private void ShowAxB()
        {
            ShowN(numberAxB, null, tbAxBB, tbAxB2, tbAxBR);
        }

        private void ShowAdB()
        {
            ShowN(numberAdB, null, tbAdBB, tbAdB2, tbAdBR);
        }

        private void ShowBdA()
        {
            ShowN(numberBdA, null, tbBdAB, tbBdA2, tbBdAR);
        }

        private void ShowAll()
        {
            ShowA();
            ShowB();
            ShowApB();
            ShowAmB();
            ShowBmA();
            ShowAxB();
            ShowAdB();
            ShowBdA();
        }

        private void btnCalcul_Click(object sender, EventArgs e)
        {
            numberApB = GetNumber(numberA.NumberR + numberB.NumberR);
            numberAmB = GetNumber(numberA.NumberR - numberB.NumberR);
            numberBmA = GetNumber(numberB.NumberR - numberA.NumberR);
            numberAxB = GetNumber(numberA.NumberR * numberB.NumberR);
            numberAdB = GetNumber(numberA.NumberR / numberB.NumberR);
            numberBdA = GetNumber(numberB.NumberR / numberA.NumberR);
            ShowAll();
        }
    }
}