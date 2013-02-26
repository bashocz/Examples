/*
 * Solution.java
 *
 * Created on December 26, 2007, 1:44 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class Solution
{
    BaseElement operand1;
    BaseElement operand2;
    Operation operator;
    
    public Solution(Matrix operand1, Matrix operand2, Operation operator)
    {
        this.operand1 = operand1;
        this.operand2 = operand2;
        this.operator = operator;
    }
    
    public Solution(Matrix operand1, Scalar operand2, Operation operator)
    {
        this.operand1 = operand1;
        this.operand2 = operand2;
        this.operator = operator;
    }
    
    public BaseElement Calculate()
    {
        Matrix matrix = (Matrix)operand1;
        if (matrix != null)
        {
            if (operator == Operation.Plus)
            {
                return matrix.PlusMatrix((Matrix)operand2);
            }
            if (operator == Operation.Minus)
            {
                return matrix.MinusMatrix((Matrix)operand2);
            }
            if (operator == Operation.MultiplyScalar)
            {
                return matrix.MultiplyScalar((Scalar)operand2);
            }
            if (operator == Operation.MultiplyMatrix)
            {
                return matrix.MultiplyMatrix((Matrix)operand2);
            }
            if (operator == Operation.Transpose)
            {
                return matrix.TransposedMatrix();
            }
            if (operator == Operation.Inverse)
            {
                return matrix.InverseMatrix();
            }
            if (operator == Operation.Determinant)
            {
                return matrix.Determinant();
            }
        }
        return null;
    }
}
