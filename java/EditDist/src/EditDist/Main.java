/*
 * Main.java
 *
 * Created on May 11, 2008, 11:49 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/*
 * Author: Petr Baros
 * Login:  bar118
 * Task:   c.7 - Vypocet editacni vzdalenosti dvou textu
 */

package EditDist;

import java.io.*;

public class Main
{
    public Main()
    {
    }
    
    // Displays help text if any argument is missing or is wrong.
    public static void printHelp()
    {
        System.out.println("Wrong program arguments:");
        System.out.println("");
        System.out.println("EditDist par1 par2 par3");
        System.out.println("");
        System.out.println("- par1 = 0 -> recurse calculation");
        System.out.println("           - par2 = 1. string using for calulation");
        System.out.println("           - par3 = 2. string using for calulation");
        System.out.println("");
        System.out.println("       = 1 -> recurse calculation helped with 2-dimensional array");
        System.out.println("           - par2 = text file with 1. string using for calulation");
        System.out.println("           - par3 = text file with 2. string using for calulation");
        System.out.println("");
        System.out.println("       = 2 -> loop calculation using 2 vectors");
        System.out.println("           - par2 = text file with 1. string using for calulation");
        System.out.println("           - par3 = text file with 2. string using for calulation");
        System.out.println("");
        System.out.println("Example:");
        System.out.println("EditDist 0 abcabba cbabac");
        System.out.println("EditDist 1 text1.txt text2.txt");
        System.out.println("EditDist 2 LargeText1.txt LargeText2.txt");
    }
    
    // Gets string from text file
    public static String getString(String fileName)
    {
        BufferedReader in = null;
        try
        {
            // open text file and read first line.
            File file = new File(fileName);
            in = new BufferedReader(new FileReader(file));
            return in.readLine();
        }
        catch (FileNotFoundException ex)
        {
            // if exception return null
            return null;
        }
        catch (IOException ex)
        {
            // if exception return null
            return null;
        }
        finally
        {
            try
            {
                // close text file
                if (in != null)
                {
                    in.close();
                }
            }
            catch (IOException ex)
            {
                // if exception return null
                return null;
            }
        }
    }
    
    // Calculate edit distance of 2 strings and displays result
    public static void editDist(EditDistInterface editDistInt, String text1, String text2)
    {
        System.out.println("Editacni vydalenost zadanych textu = " + editDistInt.Calculate(text1, text2));
    }
    
    // main method
    public static void main(String[] args)
    {
        // 3 arguments must be
        if (args.length != 3)
        {
            printHelp();
            return;
        }

        // parse first argument
        int methodIdx = 0;
        try
        {
            methodIdx = Integer.parseInt(args[0]);
        }
        catch (NumberFormatException ex)
        {
            // wrong format of first argument (must be from [0, 1, 2])
            printHelp();
            return;
        }
        
        String text1 = null;
        String text2 = null;
        EditDistInterface editDistInt = null;
        // get strings according to first argument
        switch (methodIdx)
        {
            case 0:
                // recurse method - create corresponding object
                editDistInt = new Recurse();
                // get strings from arguments
                text1 = args[1];
                text2 = args[2];
                // check strings
                if ((text1 == null) || (text2 == null))
                {
                    // wrong format of second or third argument
                    printHelp();
                    return;
                }
                // display string 1 and 2
                System.out.println("Text1 = '" + text1 + "'");
                System.out.println("Text2 = '" + text2 + "'");
                break;
            case 1:
                // recurse method with 2-dimensional array - create corresponding object
                editDistInt = new RecurseWithArray();
                // get string from files
                text1 = getString(args[1]);
                text2 = getString(args[2]);
                // check strings
                if ((text1 == null) || (text2 == null))
                {
                    // wrong format of second or third argument (missing file or file can't be read)
                    printHelp();
                    return;
                }
                // display string 1 and 2
                System.out.println("Text1 = '" + args[1] + "'");
                System.out.println("Text2 = '" + args[2] + "'");
                break;
            case 2:
                // nonrecurse method using loop and 2 vetors - create corresponding object                
                editDistInt = new Loop();
                // get strings from files
                text1 = getString(args[1]);
                text2 = getString(args[2]);
                // check strings
                if ((text1 == null) || (text2 == null))
                {
                    // wrong format of second or third argument (missing file or file can't be read)
                    printHelp();
                    return;
                }
                // displaystring 1 and 2
                System.out.println("Text1 = '" + args[1] + "'");
                System.out.println("Text2 = '" + args[2] + "'");
                break;
            default:
                // undefined number in first argument
                printHelp();
                return;
        }

        // calculate and display edit distance
        editDist(editDistInt, text1, text2);
    }
}
