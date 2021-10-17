package utils;

import java.util.Random;

/**
 *
 * @author Yap Zhen Yie
 */
public class PasswordGenerator {

    private static final char[] symbols;
    private static final Random r = new Random();

    private final char[] code;

    public PasswordGenerator(int length) {
        if (length < 1) {
            throw new IllegalArgumentException("length must higher or equal 1.");
        }
        code = new char[length];
    }

    /**
     * contains 0~9 , a~z.
     *
     */
    static {
        StringBuilder string = new StringBuilder();
        for (char num = '0'; num <= '9'; ++num) {
            string.append(num);
        }
        for (char letter = 'a'; letter <= 'z'; ++letter) {
            string.append(letter);
        }
        symbols = string.toString().toCharArray();
    }

    public String getRandomString() {
        for (int random = 0; random < code.length; ++random) {
            code[random] = symbols[r.nextInt(symbols.length)];
        }
        return new String(code);
    }

    public static String getRandomPassword() {
        return new PasswordGenerator(8).getRandomString();
    }
}
