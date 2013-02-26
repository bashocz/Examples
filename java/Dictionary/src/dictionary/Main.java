/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dictionary;

/**
 *
 * @author ffvtbn
 */
public class Main
{

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
    {
        Slovnik slovnik = new Slovnik();
        
        slovnik.nacti("C:\\slovnik.txt");

        //slovnik.setOddelovace(" ,;");
        //slovnik.add("a b, ;cde;;;");
        
        slovnik.uloz("C:\\slovnik2.txt");
    }

}
