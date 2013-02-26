/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package program;

/**
 *
 * @author ffvtbn
 */
public class Vigenere {
    public String cipher ( String openText, String password) {
        String result = "";

        for (int i = 0; i < openText.length(); i++) {
            result += (char)((password.charAt(i % password.length()) - 'a' + openText.charAt(i) - 'a') % 26 + 'a');
        }

        return result;
    }
    public String decipher ( String cipherText , String password) {
        String result = "";

        for (int i = 0; i < cipherText.length(); i++) {
            result += (char)(((cipherText.charAt(i) - 'a') - (password.charAt(i % password.length()) - 'a') + 26) % 26 + 'a');
        }

        return result;
    }
}
