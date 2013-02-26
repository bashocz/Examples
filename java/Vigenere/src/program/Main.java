/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package program;

/**
 *
 * @author ffvtbn
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        String openText = "diverttroopstoeastridge";
        String password = "white";
        Vigenere vigenere = new Vigenere();
        String cipher = vigenere.cipher(openText, password);
        String decipher = vigenere.decipher(cipher, password);

        System.out.println("Sifrovani:");
        System.out.println(password);
        System.out.println(openText);
        System.out.println(cipher);
        System.out.println("Desifrovani:");
        System.out.println(password);
        System.out.println(cipher);
        System.out.println(decipher);
    }
}
