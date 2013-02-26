/*
 * Main.java
 *
 * Created on December 5, 2007, 10:53 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package datecomparator;

import java.security.InvalidParameterException;

public class Main
{
    public class BashoDate
    {
        int day;
        int month;
        int year;
        
        char separator = '.';

        public BashoDate(String date)
        {
            if (!parseDate(date))
            {
                //throw new InvalidParameterException();
            }
        }
        
        private String[] split(String string, char separator)
        {
            int count = 1;
            for (int idx = 0; idx < string.length(); idx++)
            {
                if (string.charAt(idx) == separator)
                {
                    count++;
                }
            }
            
            String[] result = new String[count];
            int splitIdx = 0;
            result[splitIdx] = "";
            for (int idx = 0; idx < string.length(); idx++)
            {
                if (string.charAt(idx) == separator)
                {
                    splitIdx++;
                    result[splitIdx] = "";
                }
                else
                {
                    result[splitIdx] += string.charAt(idx);
                }
            }
            return result;
        }
        
        private boolean parseDate(String date)
        {
            String[] splitDate = split(date, separator);
            if (splitDate.length != 3)
            {
                return false;
            }
                
            day = Integer.parseInt(splitDate[0]);
            if ((day < 1) || (day > 31))
            {
                return false;
            }
            month = Integer.parseInt(splitDate[1]);
            if ((month < 1) || (month > 12))
            {
                return false;
            }
            year = Integer.parseInt(splitDate[2]);
            
            return true;
        }

        public boolean isLeapYear()
        {
            return (((year % 4) == 0) && ((year % 100) != 0)) || ((year % 400) == 0);
        }

        public int compare(BashoDate date)
        {
            if (year < date.getYear())
                return -1;
            if (year > date.getYear())
                return 1;
            if (month < date.getMonth())
                return -1;
            if (month > date.getMonth())
                return 1;
            if (day < date.getDay())
                return -1;
            if (day > date.getDay())
                return 1;
            return 0;
        }

        public int getDay()
        {
            return day;
        }

        public int getMonth()
        {
            return month;
        }

        public int getYear()
        {
            return year;
        }
        
        public String toString()
        {
            return Integer.toString(day) + separator + Integer.toString(month) + separator + Integer.toString(year);
        }
    }
 
    /** Creates a new instance of Main */
    public Main()
    {
    }
    
    public static void printDate(BashoDate date)
    {
        if (date.isLeapYear())
        {
            System.out.println("Zadane datum: " + date.toString() + " je prechodny rok.");
        }
        else
        {
            System.out.println("Zadane datum: " + date.toString() + " neni prechodny rok.");
        }
    }

    public static void printComparingDates(BashoDate date1, BashoDate date2)
    {
        int compare = date1.compare(date2);

        if (compare < 0)
        {
            System.out.println("Datum " + date1.toString() + " je drivejsi nez datum " + date2.toString());
        }
        else if (compare > 0)
        {
            System.out.println("Datum " + date1.toString() + " je pozdejsi nez datum " + date2.toString());
        }
        else
        {
            System.out.println("Datum " + date1.toString() + " je stejne jako datum " + date2.toString());
        }
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
    {
        String strDate1 = "10.11.1972";
        String strDate2 = "27.3.1976";
        
        BashoDate date1 = null;
        BashoDate date2 = null;

        try
        {
            date1 = new Main().new BashoDate(strDate1);
        }
        catch(Exception e)
        {
            System.out.printf("Prvni datum '" + strDate1 + "' ma chybny format.");
            return;
        }
        try
        {
            date2 = new Main().new BashoDate(strDate2);
        }
        catch(Exception e)
        {
            System.out.printf("Druhe datum '" + strDate2 + "' ma chybny format.");
            return;
        }
        
        printDate(date1);
        printDate(date2);
        printComparingDates(date1, date2);
    }
}
