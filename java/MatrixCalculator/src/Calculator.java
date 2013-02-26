/*
 * Calculator.java
 *
 * Created on December 25, 2007, 7:32 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class Calculator
{
    private Matrix[] matrixArray;
    private Solution[] solutionArray;
    
    public Calculator(SimpleWrapper wrapper)
    {
        matrixArray = wrapper.getMatrixArray();
        solutionArray = wrapper.getSolutionArray();
    }
    
    public void Calculate()
    {
        for (int idx = 0; idx < solutionArray.length; idx++)
        {
            BaseElement result = solutionArray[idx].Calculate();
            if (result != null)
            {
                result.print();
            }
            System.out.println();
        }
    }
}
