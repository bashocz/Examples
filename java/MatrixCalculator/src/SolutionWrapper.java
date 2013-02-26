/*
 * SolutionWrapper.java
 *
 * Created on December 26, 2007, 11:26 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class SolutionWrapper
{
    private String line;
    
    private String operand1;
    private String operand2;
    private Operation operator;
    
    public SolutionWrapper(String aLine)
    {
        line = aLine.trim();
        operator = Operation.Unknown;
    }
    
    public void Decode()
    {
        if (line.indexOf("+") > 0)
        {
            operator = Operation.Plus;
            operand1 = line.substring(0, 1);
            operand2 = line.substring(2, 3);
        }
        if (line.indexOf("-") > 0)
        {
            operator = Operation.Minus;
            operand1 = line.substring(0, 1);
            operand2 = line.substring(2, 3);
        }
        if (line.indexOf("*") > 0)
        {
            operator = Operation.MultiplyMatrix;
            operand1 = line.substring(0, 1);
            operand2 = line.substring(2, 3);
        }
        if (line.indexOf("^T") > 0)
        {
            operator = Operation.Transpose;
            operand1 = line.substring(0, 1);
        }
        if (line.indexOf("^-1") > 0)
        {
            operator = Operation.Inverse;
            operand1 = line.substring(0, 1);
        }
        if (line.indexOf("det(") >= 0)
        {
            operator = Operation.Determinant;
            operand1 = line.substring(4, 5);
        }
    }
    
    public String getOperand1()
    {
        return operand1;
    }
    
    public String getOperand2()
    {
        return operand2;
    }
    
    public Operation getOperator()
    {
        return operator;
    }
}
