using System;
using System.Collections.Generic;
using System.Text;

namespace Basho.RomanNumbers
{
    class Program
    {
        static string RomanDigit(int arabicDigit, string one, string five, string ten)
        {
            if ((arabicDigit < 0) || (arabicDigit > 9))
                throw new ArgumentOutOfRangeException("arabic digit", "< 0, 9 >");
            switch (arabicDigit)
            {
                case 1:
                    return one;
                case 2:
                    return one + one;
                case 3:
                    return one + one + one;
                case 4:
                    return one + five;
                case 5:
                    return five;
                case 6:
                    return five + one;
                case 7:
                    return five + one + one;
                case 8:
                    return five + one + one + one;
                case 9:
                    return one + ten;
            }
            return "";
        }

        static string RomanNumber(int arabicNumber)
        {
            if ((arabicNumber < 1) || (arabicNumber > 3999))
                throw new ArgumentOutOfRangeException("arabic number", "< 1, 3999 >");

            string one = "I", five = "V", ten = "X";
            string romanNumber = "";
            while (arabicNumber > 0)
            {
                int arabicDigit = arabicNumber % 10;
                romanNumber = RomanDigit(arabicDigit, one, five, ten) + romanNumber;

                if (one == "I")
                {
                    one = "X"; five = "L"; ten = "C";
                }
                else if (one == "X")
                {
                    one = "C"; five = "D"; ten = "M";
                }
                else
                {
                    one = "M"; five = "?"; ten = "?";
                }

                arabicNumber /= 10;
            }

            return romanNumber;
        }

        static void Test(int number)
        {
            Console.WriteLine(number + " = " + RomanNumber(number));
        }

        static void Main(string[] args)
        {
            int[] test = {
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
            21, 25, 30, 35, 40, 45, 49, 50, 60, 69, 70, 76, 80, 90, 99,
            100, 110, 150, 200, 300, 400, 499, 500, 600, 666, 700, 800, 900, 999,
            1000, 1444, 1666, 1990, 1999, 2000, 2001, 2010, 2012, 2500, 3000, 3888, 3999};

            for (int i = 0; i < test.Length; i++)
                Test(test[i]);

            Console.ReadKey();
        }
    }
}
