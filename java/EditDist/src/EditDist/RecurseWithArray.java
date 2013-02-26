/*
 * RecurseWithArray.java
 *
 * Created on May 11, 2008, 11:56 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package EditDist;

// class supported recurse method helped with 2-dimensional array
public class RecurseWithArray implements EditDistInterface
{
    // private variables
    private String text1;
    private String text2;
    private int[][] array;
    
    // constructor
    public RecurseWithArray()
    {
    }
    
    // recurse method for calculation
    private int editDist(int i, int j)
    {
        if (array[i][j] < 0)
        {
            // calculate edit distance if isn't calculated yet
            // initialize the value (defined value when i = j = 0)
            array[i][j] = 0;
            if (i > 0)
            {
                if (j > 0)
                {
                    // calculate edit distance usinq recurse method
                    // compare characters on position i, j
                    if (text1.charAt(i - 1) == text2.charAt(j - 1))
                    {
                        // charactes are equal
                        array[i][j] = editDist(i - 1, j - 1);
                    }
                    else
                    {
                        // charactes are different
                        array[i][j] = Math.min(editDist(i - 1, j) + 1, Math.min(editDist(i, j - 1) + 1, editDist(i - 1, j - 1) + 1));
                    }
                }
                else
                    // defined value when j = 0
                    array[i][j] = i;
            }
            else
            {
                if (j > 0)
                    // defined value when i = 0
                    array[i][j] = j;
            }
        }
        // return calculated edit distance stored in help array
        return array[i][j];
    }
    
    // public method for calculation of edit distance of two strings
    public int Calculate(String text1, String text2)
    {
        // both texts must be defined
        if ((text1 != null) && (text2 != null) && (text1.length() > 0) && (text2.length() > 0))
        {
            this.text1 = text1;
            this.text2 = text2;
            
            // initialize 2-dimensional array using for faster calculation of edit distance
            array = new int[text1.length() + 1][text2.length() + 1];
            for (int i = 0; i < array.length; i++)
                for (int j = 0; j < array[0].length; j++)
                    array[i][j] = -1;
            
            // call recurse method and return result
            return editDist(text1.length(), text2.length());
        }
        // choose by author -> missing in task definition -> deducation from example table
        return 0;
    }
}
