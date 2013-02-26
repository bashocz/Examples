/*
 * BaseElement.java
 *
 * Created on December 25, 2007, 12:35 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Basho
 */
public class BaseElement
{
    protected String name;
    
    public BaseElement(String name)
    {
        this.name = name;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void print()
    {        
    }
}
