/*
 * Main.java
 *
 * Created on April 4, 2008, 5:43 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package fib;

/**
 *
 * @author ffvtbn
 */
public class Main {
    
    /** Creates a new instance of Main */
    public Main() {
    }
    
    public static int Fib(int n)
    {
        if ((n == 0) || (n == 1))
            return 1;
        else
            return Fib(n-1) + Fib(n-2);
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
    {
        System.out.println(Fib(48));
    }
    
}
