/*
 * main.java
 *
 * Created on December 25, 2007, 12:11 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class main
{
    public main()
    {
    }
    
    public static void main(String[] args)
    {
        if (args.length == 1)
        {
            try
            {
                SimpleWrapper wrapper = new SimpleWrapper(args[0]);
                Calculator calculator = new Calculator(wrapper);
                calculator.Calculate();
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
    }
}
