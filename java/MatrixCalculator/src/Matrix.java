/*
 * Matrix.java
 *
 * Created on December 25, 2007, 2:19 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class Matrix extends BaseElement
{
    double[][] mArray;
    
    public Matrix(String name, double[][] array)
    {
        super(name);

        if (array == null)
            throw new NullPointerException("Argument array is null.");
        if (array.length == 0)
            throw new ArrayIndexOutOfBoundsException("Y size of array is zero.");
        if (array[0].length == 0)
            throw new ArrayIndexOutOfBoundsException("X size of array is zero.");
        int xSize = array[0].length;
        for (int row = 1; row < array.length; row++)
        {
            if (array[row].length != xSize)
            {
                throw new ArrayIndexOutOfBoundsException("X size of array is different.");
            }
        }
        
        mArray = new double[array.length][array[0].length];
        for (int row = 0; row < array.length; row++)
        {
            for (int col = 0; col < array[0].length; col++)
            {
                mArray[row][col] = array[row][col];
            }
        }
    }
    
    private double[][] insertRow(double[][] array, int index, double[] newRow)
    {
        if (newRow == null)
            throw new NullPointerException("Argument newRow is null.");
        if (newRow.length != array[0].length)
            throw new ArithmeticException("Length of newRow is different than X size of matrix.");
        if ((index < 0) || (index > array.length))
            throw new IndexOutOfBoundsException("Index is out of bounds.");
        
        double[][] retArray = new double[array.length + 1][array[0].length];
        int idx = 0;
        for (int row = 0; row < retArray.length; row++)
        {
            if (row == index)
            {
                for (int col = 0; col < retArray[0].length; col++)
                {
                    retArray[row][col] = newRow[col];
                }
            }
            else
            {
                for (int col = 0; col < retArray[0].length; col++)
                {
                    retArray[row][col] = array[idx][col];
                }
                idx++;
            }
        }
        return retArray;
    }
    
    public void AddRow(double[] newRow)
    {
        mArray = insertRow(mArray, mArray.length, newRow);
    }
    
    public void InsertRow(int index, double[] newRow)
    {
        mArray = insertRow(mArray, index, newRow);
    }
    
    private double[][] deleteRow(double[][] array, int index)
    {
        if ((index < 0) || (index >= array.length))
            throw new IndexOutOfBoundsException("Index is out of bounds.");
        if (array.length < 2)
            throw new IndexOutOfBoundsException("Can't delete last row of metrix.");
        
        double[][] retArray = new double[array.length - 1][array[0].length];
        int idx = 0;
        for (int row = 0; row < array.length; row++)
        {
            if (row != index)
            {
                for (int col = 0; col < array[0].length; col++)
                {
                    retArray[idx][col] = array[row][col];
                }
                idx++;
            }
        }
        return retArray;
    }
    
    public void DeleteRow(int index)
    {
        mArray = deleteRow(mArray, index);
    }
    
    private double[][] insertCol(double[][] array, int index, double[] newCol)
    {
        if (newCol == null)
            throw new NullPointerException("Argument newCol is null.");
        if (newCol.length != array.length)
            throw new ArithmeticException("Length of newCol is different than Y size of matrix.");
        if ((index < 0) || (index > array[0].length))
            throw new IndexOutOfBoundsException("Index is out of bounds.");
        
        double[][] retArray = new double[array.length][array[0].length + 1];
        for (int row = 0; row < retArray.length; row++)
        {
            int idx = 0;
            for (int col = 0; col < retArray[0].length; col++)
            {
                if (col == index)
                {
                    retArray[row][col] = newCol[row];
                }
                else
                {
                    retArray[row][col] = array[row][idx];
                    idx++;
                }
            }
        }
        return retArray;
    }
    
    public void AddCol(double[] newCol)
    {
        mArray = insertCol(mArray, mArray[0].length, newCol);
    }
    
    public void InsertCol(int index, double[] newCol)
    {
        mArray = insertCol(mArray, index, newCol);
    }
    
    private double[][] deleteCol(double[][] array, int index)
    {
        if ((index < 0) || (index >= array[0].length))
            throw new IndexOutOfBoundsException("Index is out of bounds.");
        if (array[0].length < 2)
            throw new IndexOutOfBoundsException("Can't delete last column of metrix.");
    
        double[][] retArray = new double[array.length][array[0].length - 1];
        for (int row = 0; row < array.length; row++)
        {
            int idx = 0;
            for (int col = 0; col < array[0].length; col++)
            {
                if (col != index)
                {
                    retArray[row][idx] = array[row][col];
                    idx++;
                }
            }
        }
        return retArray;
    }
    
    public void DeleteCol(int index)
    {
        mArray = deleteCol(mArray, index);
    }
    
    private double[][] plusMatrix(double[][] array1, double[][] array2)
    {
        if (array1.length != array2.length)
            throw new ArithmeticException("Matrixes have different Y size.");
        if (array1[0].length != array2[0].length)
            throw new ArithmeticException("Matrixes have different X size.");
        
        double[][] retArray = new double[array1.length][array1[0].length];
        for (int row = 0; row < array1.length; row++)
        {
            for (int col = 0; col < array1[0].length; col++)
            {
                retArray[row][col] = array1[row][col] + array2[row][col];
            }
        }
        return retArray;
    }
    
    public Matrix PlusMatrix(Matrix matrix)
    {
        if (matrix == null)
            throw new NullPointerException("Argument matrix is null");
        
        return new Matrix(name + " + " + matrix.getName(), plusMatrix(mArray, matrix.getArray()));
    }
    
    private double[][] minusMatrix(double[][] array1, double[][] array2)
    {
        if (array1.length != array2.length)
            throw new ArithmeticException("Matrixes have different Y size.");
        if (array1[0].length != array2[0].length)
            throw new ArithmeticException("Matrixes have different X size.");
        
        double[][] retArray = new double[array1.length][array1[0].length];
        for (int row = 0; row < array1.length; row++)
        {
            for (int col = 0; col < array1[0].length; col++)
            {
                retArray[row][col] = array1[row][col] - array2[row][col];
            }
        }
        return retArray;
    }
    
    public Matrix MinusMatrix(Matrix matrix)
    {
        if (matrix == null)
            throw new NullPointerException("Argument matrix is null");
        
        return new Matrix(name + " - " + matrix.getName(), minusMatrix(mArray, matrix.getArray()));
    }
    
    private double[][] multiplyScalar(double[][] array, double scalar)
    {
        double[][] retArray = new double[array.length][array[0].length];
        for (int row = 0; row < array.length; row++)
        {
            for (int col = 0; col < array[0].length; col++)
            {
                retArray[row][col] = scalar * array[row][col];
            }
        }
        return retArray;
    }
    
    public Matrix MultiplyScalar(Scalar scalar)
    {
        if (scalar == null)
            throw new NullPointerException("Argument scalar is null");
        
        return new Matrix(scalar.getName() + " * " + name, multiplyScalar(mArray, scalar.getNumber()));
    }
    
    private double[][] multiplyMatrix(double[][] array1, double[][] array2)
    {
        if (array1[0].length != array2.length)
            throw new ArithmeticException("Can't multiply matrixes.");
        
        double[][] retArray = new double[array1.length][array2[0].length];
        for (int row = 0; row < array1.length; row++)
        {
            for (int col = 0; col < array2[0].length; col++)
            {
                retArray[row][col] = 0;
                for (int idx = 0; idx < array1[0].length; idx++)
                {
                    retArray[row][col] += array1[row][idx] * array2[idx][col];
                }                
            }
        }
        return retArray;
    }
    
    public Matrix MultiplyMatrix(Matrix matrix)
    {
        if (matrix == null)
            throw new NullPointerException("Argument matrix is null");
        
        return new Matrix(name + " * " + matrix.getName(), multiplyMatrix(mArray, matrix.getArray()));
    }
    
    private double[][] subMatrix(double[][] array, int row, int col)
    {
        double[][] retArray = deleteRow(array, row);
        retArray = deleteCol(retArray, col);
        return retArray;
    }
    
    public Matrix SubMatrix(int row, int col)
    {
        return new Matrix("sub(" + name + ")", subMatrix(mArray, row, col));
    }
    
    private double[][] transposedMatrix(double[][] array)
    {
        double[][] retArray = new double[array[0].length][array.length];
        for (int row = 0; row < array.length; row++)
        {
            for (int col = 0; col < array[0].length; col++)
            {
                retArray[col][row] = array[row][col];
            }
        }
        return retArray;
    }
    
    public Matrix TransposedMatrix()
    {
        return new Matrix(name + "^T", transposedMatrix(mArray));
    }
    
    private boolean isZero(double number)
    {
        return (Math.abs(number - 1e-20) < 1e-20);
    }
    
    // very slow method
    private double determinant(double[][] array)
    {
        if (array.length != array[0].length)
            throw new ArithmeticException("Matrix isn't squared.");
        
        if (array.length == 1)
        {
            return array[0][0];
        }
        
        double det = 0;
        for (int row = 0; row < array.length; row++)
        {
            if (isZero(array[row][0]) == false)
            {
                double[][] subArray = subMatrix(array, row, 0);
                det += Math.pow(-1, row) * array[row][0] * determinant(subArray);
            }            
        }        
        return det;
    }
    
    public Scalar Determinant()
    {
        return new Scalar("det(" + name + ")", determinant(mArray));
    }
    
    private double[][] inverseMatrix(double[][] array)
    {
        if (array.length != array[0].length)
            throw new ArithmeticException("Matrix isn't squared.");
        
        double det = determinant(array);        
        if (isZero(det) == true)
            throw new ArithmeticException("Matrix is singular.");
        
        double[][] retArray = new double[array.length][array[0].length];
        for (int row = 0; row < array.length; row++)
        {
            for (int col = 0; col < array[0].length; col++)
            {
                double[][] subArray = subMatrix(array, row, col);
                retArray[row][col] = Math.pow(-1, row + col) * determinant(subArray);
            }
        }
        retArray = transposedMatrix(retArray);
        return multiplyScalar(retArray, 1 / det);
    }
    
    public Matrix InverseMatrix()
    {
        return new Matrix(name + "^-1", inverseMatrix(mArray));
    }
    
    public int getXSize()
    {
        return mArray[0].length;
    }
    
    public int getYSize()
    {
        return mArray.length;
    }
    
    public double getElement(int row, int col)
    {
        if ((row < 0) || (row >= mArray.length))
            throw new IndexOutOfBoundsException("Row is out of bounds.");
        if ((col < 0) || (col >= mArray[0].length))
            throw new IndexOutOfBoundsException("Col is out of bounds.");
        
        return mArray[row][col];
    }
    
    public double[][] getArray()
    {
        return mArray;
    }
    
    public void print()
    {
        String[][] strArray = new String[mArray.length][mArray[0].length];
        int maxLength = 0;
        for (int row = 0; row < mArray.length; row++)
        {
            for (int col = 0; col < mArray[0].length; col++)
            {
                strArray[row][col] = Double.toString(mArray[row][col]);
                if (maxLength < strArray[row][col].length())
                    maxLength = strArray[row][col].length();
            }
        }
        for (int row = 0; row < mArray.length; row++)
        {
            for (int col = 0; col < mArray[0].length; col++)
            {
                while (strArray[row][col].length() < maxLength)
                {
                    strArray[row][col] = " " + strArray[row][col];
                }
            }
        }
        System.out.println(name + " =");
        for (int row = 0; row < mArray.length; row++)
        {
            System.out.print("| ");
            for (int col = 0; col < mArray[0].length; col++)
            {
                System.out.print(strArray[row][col] + " ");
            }
            System.out.println("|");
        }
    }
}
