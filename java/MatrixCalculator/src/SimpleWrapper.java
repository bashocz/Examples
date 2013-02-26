import java.io.*;
/*
 * SimpleWrapper.java
 *
 * Created on December 26, 2007, 11:53 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class SimpleWrapper
{
    private boolean isAssignment = false;
    private boolean isSolution = false;
    
    private MatrixWrapper actualMatrixWrapper = null;
    private MatrixWrapper[] matrixWrapperArray;
    private SolutionWrapper[] solutionWrapperArray;
    
    private Matrix[] matrixArray;
    private Solution[] solutionArray;

    public SimpleWrapper(String fileName)
    throws IOException, FileNotFoundException
    {
        matrixWrapperArray = new MatrixWrapper[0];
        solutionWrapperArray = new SolutionWrapper[0];
        
        matrixArray = new Matrix[0];
        solutionArray = new Solution[0];
        
        BufferedReader in = null;
        try
        {
            File file = new File(fileName);
            in = new BufferedReader(new FileReader(file));
            String line;
            while ((line = in.readLine()) != null)
            {
                decodeLine(line);
            }
            
            decodeWrappers();
            
            if ((matrixArray.length == 0) || (solutionArray.length == 0))
            {
                throw new IOException("Wrong input format.");
            }
        }
        catch (FileNotFoundException ex)
        {
            throw ex;
        }
        catch (IOException ex)
        {
            throw ex;
        }
        finally
        {
            try
            {
                if (in != null)
                {
                    in.close();
                }
            }
            catch (IOException ex)
            {
                throw ex;
            }
        }
    }
    
    private void decodeLine(String line)
    {
        if (line.isEmpty())
            return;
        
        if (!isAssignment)
        {
            if (line.compareToIgnoreCase("zadani:") == 0)
            {
                isAssignment = true;
            }
        }
        else
        {
            if (!isSolution)
            {
                if (line.compareToIgnoreCase("reseni:") == 0)
                {
                    isSolution = true;
                }
                else
                {
                    addAssignmentLine(line);
                }
            }
            else
            {
                addSolutionLine(line);
            }
        }
    }
    
    private void addAssignmentLine(String line)
    {
        if (line.indexOf("=") >= 0)
        {
            addMatrixWrapper(line);
        }
        else
        {
            if (actualMatrixWrapper != null)
            {
                actualMatrixWrapper.AddLine(line);
            }
        }
    }
    
    private void addMatrixWrapper(String line)
    {
        MatrixWrapper[] newArray = new MatrixWrapper[matrixWrapperArray.length + 1];
        for (int idx = 0; idx < matrixWrapperArray.length; idx++)
        {
            newArray[idx] = matrixWrapperArray[idx];
        }
        actualMatrixWrapper = new MatrixWrapper(line);
        newArray[newArray.length - 1] = actualMatrixWrapper;
        matrixWrapperArray = newArray;
    }
    
    private void addSolutionLine(String line)
    {
        SolutionWrapper[] newArray = new SolutionWrapper[solutionWrapperArray.length + 1];
        for (int idx = 0; idx < solutionWrapperArray.length; idx++)
        {
            newArray[idx] = solutionWrapperArray[idx];
        }
        newArray[newArray.length - 1] = new SolutionWrapper(line);
        solutionWrapperArray = newArray;
    }
    
    private Matrix getMatrix(String name)
    {
        if (name == null)
            return null;
        
        for (int idx = 0; idx < matrixArray.length; idx++)
        {
            if (name.compareToIgnoreCase(matrixArray[idx].getName()) == 0)
            {
                return matrixArray[idx];
            }
        }
        return null;
    }
    
    private void decodeWrappers()
    throws IOException
    {
        for (int idx = 0; idx < matrixWrapperArray.length; idx++)
        {
            try
            {
                matrixWrapperArray[idx].Decode();
            }
            catch (Exception ex)
            {
                throw new IOException(ex);
            }
        }
        
        matrixArray = new Matrix[matrixWrapperArray.length];        
        for (int idx = 0; idx < matrixArray.length; idx++)
        {
            matrixArray[idx] = new Matrix(matrixWrapperArray[idx].getName(),
                matrixWrapperArray[idx].getArray());
        }
        
        for (int idx = 0; idx < solutionWrapperArray.length; idx++)
        {
            solutionWrapperArray[idx].Decode();
            if (solutionWrapperArray[idx].getOperator() == Operation.Unknown)
            {
                throw new IOException("Wrong input format.");
            }
        }
        
        solutionArray = new Solution[solutionWrapperArray.length];
        for (int idx = 0; idx < solutionArray.length; idx++)
        {
            Matrix matrix1 = getMatrix(solutionWrapperArray[idx].getOperand1());
            Matrix matrix2 = getMatrix(solutionWrapperArray[idx].getOperand2());
            solutionArray[idx] = new Solution(matrix1, matrix2,
                solutionWrapperArray[idx].getOperator());
        }
    }
    
    public Matrix[] getMatrixArray()
    {
        return matrixArray;
    }
    
    public Solution[] getSolutionArray()
    {
        return solutionArray;
    }
}
