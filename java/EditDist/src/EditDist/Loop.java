/*
 * Loop.java
 *
 * Created on May 11, 2008, 11:57 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package EditDist;

// class supported non-recurse method using two vectors
public class Loop implements EditDistInterface
{
    // constructor
    public Loop()
    {
    }
    
    // public method for calculation of edit distance of two strings
    public int Calculate(String text1, String text2)
    {
        // both texts must be defined
        if ((text1 != null) && (text2 != null) && (text1.length() > 0) && (text2.length() > 0))
        {
            int[] lastDist = new int[text1.length() + 1]; // last row's distances
            int[] actDist = new int[text1.length() + 1]; // actual row's distances

            // initialize lastDist array
            for (int idx = 0; idx < lastDist.length; idx++)
            {
                lastDist[idx] = idx;
            }

            // main loop algorithm
            for (int line = 0; line < text2.length(); line++)
            {
                actDist[0] = line + 1; //  distance on 0 position
                
                for (int idx = 1; idx < lastDist.length; idx++)
                {
                    // compare characters
                    actDist[idx] = (text1.charAt(idx - 1) == text2.charAt(line))
                        // characters are equal
                        ? lastDist[idx - 1]
                        // characters are different
                        : Math.min(actDist[idx - 1] + 1, Math.min(lastDist[idx] + 1, lastDist[idx - 1] + 1));
                }
                
                // copy calculated values from actual vector to last vector
                for (int idx = 0; idx < lastDist.length; idx++)
                {
                    lastDist[idx] = actDist[idx];
                }
            }

            // return last calculated value as "edit distance of two string"
            return lastDist[lastDist.length - 1];
        }
         // choose by author -> missing in task definition -> deducation from example table
        return 0;
    }
}
