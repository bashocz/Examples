/*
 * Vector.java
 *
 * Created on December 25, 2007, 12:39 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class Vector extends BaseElement
{
    double[] mArray;
    
    public Vector(String name, double[] array)
    {
        super(name);
        
        if (array == null)
            throw new NullPointerException("Argument array is null.");
        if (array.length == 0)
            throw new ArrayIndexOutOfBoundsException("Length of array is zero.");
        
        mArray = new double[array.length];
        System.arraycopy(array, 0, mArray, 0, array.length);
    }
    
    private double[] insertElement(double[] array, int index, double number)
    {
        if ((index < 0) || (index > array.length))
            throw new IndexOutOfBoundsException("Index is out of bounds.");
        
        double[] retArray = new double[array.length + 1];
        int idx = 0;        
        for (int rIdx = 0; rIdx < retArray.length; rIdx++)
        {
            if (rIdx == index)
            {
                retArray[rIdx] = number;
            }
            else
            {
                retArray[rIdx] = array[idx];
                idx++;
            }
        }
        return retArray;
    }
    
    public void AddElement(double number)
    {
        mArray = insertElement(mArray, mArray.length, number);
    }
    
    public void InsertElement(int index, double number)
    {
        mArray = insertElement(mArray, index, number);
    }
    
    private double[] deleteElement(double[] array, int index)
    {
        if ((index < 0) || (index >= array.length))
            throw new IndexOutOfBoundsException("Index is out of bounds.");
        if (array.length < 2)
            throw new IndexOutOfBoundsException("Can't delete last element of vector.");
        
        double[] retArray = new double[array.length - 1];
        int rIdx = 0;        
        for (int idx = 0; idx < array.length; idx++)
        {
            if (rIdx != index)
            {
                retArray[rIdx] = array[idx];
                rIdx++;
            }
        }
        return retArray;
    }
    
    public void DeleteElement(int index)
    {
        mArray = deleteElement(mArray, index);
    }
    
    private double scalarMultiply(double[] array1, double[] array2)
    {
        if (array1.length != array2.length)
            throw new ArithmeticException("Vectors must have same length.");
        
        double scalar = 0;
        for (int idx = 0; idx < array1.length; idx++)
        {
            scalar += array1[idx] * array2[idx];
        }
        return Math.sqrt(scalar);
    }
    
    public Scalar ScalarMultiply(Vector vector)
    {
        if (vector == null)
            throw new NullPointerException("Argument vector is null");
       
        return new Scalar(name + " x " + vector.getName(), scalarMultiply(mArray, vector.getArray()));
    }
    
    private double[] plusVector(double[] array1, double[] array2)
    {
        if (array1.length != array2.length)
            throw new ArithmeticException("Vectors must have same length.");
        
        double[] retArray = new double[array1.length];
        for (int idx = 0; idx < array1.length; idx++)
        {
            retArray[idx] = array1[idx] + array2[idx];
        }
        return retArray;
    }
    
    public Vector PlusVector(Vector vector)
    {
        if (vector == null)
            throw new NullPointerException("Argument vector is null");
                
        return new Vector(name + " + " + vector.getName(), plusVector(mArray, vector.getArray()));
    }
    
    private double[] minusVector(double[] array1, double[] array2)
    {        
        if (array1.length != array2.length)
            throw new ArithmeticException("Vectors must have same length.");
        
        double[] retArray = new double[array1.length];
        for (int idx = 0; idx < array1.length; idx++)
        {
            retArray[idx] = array1[idx] - array2[idx];
        }
        return retArray;
    }
    
    public Vector MinusVector(Vector vector)
    {
        if (vector == null)
            throw new NullPointerException("Argument vector is null");
        
        return new Vector(name + " - " + vector.getName(), minusVector(mArray, vector.getArray()));
    }
    
    public double getLength()
    {
        return mArray.length;
    }
    
    public double getElement(int index)
    {
        if ((index < 0) || (index >= mArray.length))
            throw new IndexOutOfBoundsException("Index is out of bounds.");
        
        return mArray[index];
    }
    
    public double[] getArray()
    {
        return mArray;
    }
    
    public void print()
    {
        System.out.print(name + " = [");
        for (int idx = 0; idx < mArray.length; idx++)
        {
            if (idx == 0)
            {
                System.out.print(", ");
            }
            System.out.print(mArray[idx]);
        }
        System.out.println("]");
    }
}
