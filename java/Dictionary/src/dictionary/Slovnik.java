/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dictionary;

import java.io.*;

/**
 *
 * @author ffvtbn
 */
public class Slovnik
{
    private String oddelovace;
    private String[] slovnik;
    
    public Slovnik()
    {
        oddelovace = "";
        slovnik = new String[0];
    }
    
    public int getPocet()
    {
        return slovnik.length;
    }
    
    private Boolean jeOddelovac(char znak)
    {
        for (int i = 0; i < oddelovace.length(); i++)
        {
            if (oddelovace.charAt(i) == znak)
                return true;
        }
        return false;
    }
    
    private void addSlovo(String slovo)
    {
        try
        {
            hledej(slovo);
            return;
        }
        catch (Exception ex)
        {
        }
        
        String[] tempSlovnik = new String[slovnik.length + 1];
        for (int i = 0; i < slovnik.length; i++)
            tempSlovnik[i] = slovnik[i];
        tempSlovnik[tempSlovnik.length - 1] = slovo;
        slovnik = tempSlovnik;
    }
    
    public void setOddelovace(String oddelovace)
    {
        this.oddelovace = oddelovace;
    }
    
    public void add(String text)
    {
        if (text != null)
        {
            int i = 0;
            while (i < text.length())
            {
                while ((i < text.length()) && jeOddelovac(text.charAt(i)))
                    i++;            
                String slovo = "";
                while ((i < text.length()) && !jeOddelovac(text.charAt(i)))
                {
                    slovo += text.charAt(i);
                    i++;
                }
                if (slovo.length() > 0)
                {
                    addSlovo(slovo);
                }
                i++;
            }
        }
    }    
    
    public String hledej(String vzor) throws Exception
    {
        for (int i = 0; i < slovnik.length; i++)
        {
            //if (slovnik[i].equalsIgnoreCase(vzor))
            if (slovnik[i].equals(vzor))
                return vzor;
        }
        throw new Exception("Slovo nenalezeno");
    }
    
    @Override public String toString()
    {
        String text = "";
        for (int i = 0; i < slovnik.length; i++)
            text += slovnik[i] + ", ";
        return text;
    }
    
    public void uloz(String jmenoSouboru)
    {
        try
        {
            PrintWriter soubor = new PrintWriter(new FileWriter(jmenoSouboru, false));
            soubor.println(oddelovace);
            for (int i = 0; i < slovnik.length; i++)
                soubor.println(slovnik[i]);
            soubor.close();
        }
        catch(IOException ex)
        {
            System.out.println("Chyba pri zapisu do souboru.");
        }    
    }
    
    public void nacti(String jmenoSouboru)
    {
        try
        {
            BufferedReader soubor = new BufferedReader(new FileReader(jmenoSouboru));
            
            String slovo = soubor.readLine();
            if (slovo != null)
                oddelovace = slovo;
            while (slovo != null)
            {
                slovo = soubor.readLine();
                if (slovo != null)
                {
                    addSlovo(slovo);
                }
            }
            soubor.close();
        }
        catch (IOException ex)
        {
            System.out.println("Chyba pri cteni ze souboru");
        }
    }
}
