/*
 * MatrixWrapper.java
 *
 * Created on December 26, 2007, 11:15 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class MatrixWrapper
{
    String name;
    String[] strArray;
    double[][] dblArray;
    
    public MatrixWrapper(String firstLine)
    {
        name = firstLine.substring(0, 1);
        strArray = new String[0];
        dblArray = new double[0][0];
    }
    
    public void AddLine(String line)
    {
        String[] newArray = new String[strArray.length + 1];
        for (int idx = 0; idx < strArray.length; idx++)
        {
            newArray[idx] = strArray[idx];
        }
        newArray[newArray.length - 1] = line;
        strArray = newArray;
    }
    
    private double[] addNumber(double[] array, double number)
    {
        double[] newArray = new double[array.length + 1];
        for (int idx = 0; idx < array.length; idx++)
        {
            newArray[idx] = array[idx];
        }
        newArray[newArray.length - 1] = number;
        return newArray;
    }
    
    public void Decode()
    throws Exception
    {
        double[][] newArray = new double[strArray.length][];
        for (int row = 0; row < strArray.length; row++)
        {
            newArray[row] = new double[0];
            String line = strArray[row];
            while (line.length() > 0)
            {
                line = line.trim();
                int spacePos = line.indexOf(' ');
                String strNumber = null;
                if (spacePos > 0)
                {
                    strNumber = line.substring(0, spacePos);
                    line = line.substring(spacePos);
                }
                else
                {
                    strNumber = line;
                    line = "";
                }
                strNumber = strNumber.trim();
                double number = Double.parseDouble(strNumber);
                newArray[row] = addNumber(newArray[row], number);
            }
        }
        if (newArray.length == 0)
        {
            throw new Exception("Wrong input format.");
        }
        
        int ySize = newArray[0].length;
        for (int row = 0; row < newArray.length; row++)
        {
            if (newArray[row].length != ySize)
            {
                throw new Exception("Wrong input format.");
            }
        }
        dblArray = newArray;
    }
    
    public String getName()
    {
        return name;
    }
    
    public double[][] getArray()
    {
        return dblArray;
    }
}
