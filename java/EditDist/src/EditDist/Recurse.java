/*
 * RecurseCalculation.java
 *
 * Created on May 11, 2008, 11:52 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package EditDist;

// class supported basic recurse method
public class Recurse implements EditDistInterface
{    
    // private variables
    private String text1;
    private String text2;
    
    // constructor
    public Recurse()
    {
    }
    
    // recurse method for calculation
    // - there will better to define text1 and text2 as parameters of method for universal use
    // - author selects object private variables to save computer resources (memory, heap and speed)
    private int editDist(int i, int j)
    {
        if (i > 0)
        {
            if (j > 0)
            {
                // calculate edit distance usinq recurse method
                // compare characters on position i, j
                if (text1.charAt(i - 1) == text2.charAt(j - 1))
                {
                    // charactes are equal
                    return editDist(i - 1, j - 1);
                }
                else
                {
                    // charactes are different
                    return Math.min(editDist(i - 1, j) + 1, Math.min(editDist(i, j - 1) + 1, editDist(i - 1, j - 1) + 1));
                }
            }
            // defined result when j = 0
            return i;
        }
        if (j > 0)
            // defined result when i = 0
            return j;
        // defined result when i = j = 0
        return 0;
    }
    
    // public method for calculation of edit distance of two strings
    public int Calculate(String text1, String text2)
    {
        // both texts must be defined
        if ((text1 != null) && (text2 != null) && (text1.length() > 0) && (text2.length() > 0))
        {
            this.text1 = text1;
            this.text2 = text2;
            
            // call recurse method and return the result
            return editDist(text1.length(), text2.length());
        }
        // choose by author -> missing in task definition -> deducation from example table
        return 0;
    }
}
