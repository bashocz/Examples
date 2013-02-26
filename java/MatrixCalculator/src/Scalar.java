/*
 * Scalar.java
 *
 * Created on December 25, 2007, 12:37 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class Scalar extends BaseElement
{
    double number;
    
    public Scalar(String name, double number)
    {
        super(name);
        
        this.number = number;
    }
    
    public double getNumber()
    {
        return number;
    }
    
    public void print()
    {
        System.out.print(name + " = ");
        System.out.println(number);
    }
}
