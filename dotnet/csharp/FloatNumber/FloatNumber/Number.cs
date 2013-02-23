using System;
using System.Collections.Generic;
using System.Text;

namespace Basho.FloatNumber
{
    public class FloatNumber
    {
        private class ExpNumber
        {
            private readonly double number;
            private readonly int baseX;
            private readonly double significand;
            private readonly int exponent;
            private readonly string numberStr;

            public ExpNumber(double number, int baseX)
            {
                this.number = number;
                this.baseX = baseX;

                significand = number;
                exponent = 0;
                int step = (Math.Abs(significand) < 1) ? -1 : 1;
                if (significand != 0)
                {
                    while ((Math.Abs(significand) < 1) || (Math.Abs(significand) >= baseX))
                    {
                        significand /= Math.Pow(baseX, step);
                        exponent += step;
                    }
                }
                numberStr = significand.ToString("0.00000") + "*" + baseX.ToString() + "^" + exponent.ToString();
            }

            public override string ToString()
            {
                return numberStr;
            }

            public double Number
            {
                get { return number; }
            }

            public int Base
            {
                get { return baseX; }
            }

            public double Significand
            {
                get { return significand; }
            }

            public int Exponent
            {
                get { return exponent; }
            }
        }

        private readonly double number;
        private readonly int mantisaBits;
        private readonly int exponentBits;

        private ExpNumber number10;
        private ExpNumber number2;
        private ExpNumber numberR;

        private string mantisa2;
        private string exponent2;

        public FloatNumber(double number, int mantisaBits, int exponentBits)
        {
            this.number = number;
            this.mantisaBits = mantisaBits;
            this.exponentBits = exponentBits;

            Convert();
        }

        private string ConvertMantisa(double significand)
        {
            significand = Math.Abs(significand) - 1;
            string strMantisaX = string.Empty;
            while (strMantisaX.Length < (mantisaBits - 1))
            {
                significand *= 2;
                if (significand < 1)
                    strMantisaX += "0";
                else
                {
                    strMantisaX += "1";
                    significand -= 1;
                }
            }
            return strMantisaX;
        }

        private string ConvertExponent(int exponent)
        {
            int exponentMax = (int)Math.Round(Math.Pow(2, exponentBits));
            exponent += exponentMax / 2;
            if (exponent < 0)
                throw new OverflowException("Number is too small");
            if (exponent >= (exponentMax))
                throw new OverflowException("Number is too high");

            string strExponentX = string.Empty;
            for (int idx = 0; idx < exponentBits; idx++)
            {
                strExponentX = (((exponent % 2) > 0) ? "1" : "0") + strExponentX;
                exponent /= 2;
            }
            return strExponentX;
        }

        private ExpNumber GetNumberR(ExpNumber number2)
        {
            double step = 1;
            double numberX = step;
            string mantisaX = ConvertMantisa(number2.Significand);
            for (int idx = 0; idx < mantisaX.Length; idx++)
            {
                step /= 2;
                if (mantisaX[idx] == '1')
                    numberX += step;
            }
            if (number2.Significand < 0)
                numberX *= -1;
            numberX *= Math.Pow(2, number2.Exponent);
            return new ExpNumber(numberX, 10);
        }

        private void Convert()
        {
            number10 = new ExpNumber(number, 10);
            number2 = new ExpNumber(number, 2);
            numberR = GetNumberR(number2);
            mantisa2 = ConvertMantisa(number2.Significand);
            exponent2 = ConvertExponent(number2.Exponent);
        }

        public double Number
        {
            get { return number; }
        }

        public double NumberR
        {
            get { return numberR.Number; }
        }

        public string StrBinary
        {
            get
            {
                string binary = ((number < 0) ? "1" : "0") + exponent2 + mantisa2;
                string binaryX = string.Empty;
                int digits = 0;
                for (int idx = binary.Length - 1; idx >= 0; idx--)
                {
                    if (digits > 3)
                    {
                        binaryX = " " + binaryX;
                        digits = 0;
                    }
                    binaryX = binary[idx] + binaryX;
                    digits++;
                }
                return binaryX;
            }
        }

        public string StrMantisa
        {
            get { return mantisa2; }
        }

        public string StrExp
        {
            get { return exponent2; }
        }

        public string StrNumberR
        {
            get { return numberR.ToString(); }
        }

        public string StrNumber10
        {
            get { return number10.ToString(); }
        }

        public string StrNumber2
        {
            get { return number2.ToString(); }
        }
    }
}
