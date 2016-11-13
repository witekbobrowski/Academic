package start;

import java.util.Scanner;

public class Divide {
    public static double div(double a, double b) throws DivideByZeroException {
        double result = 0;
        String sA= Double.toString(a);
        String sB= Double.toString(b);
        try {
            if (b == 0){
                throw new DivideByZeroException(sA, sB);
            }
            result = a / b;
        } catch(DivideByZeroException ex){
            System.err.println(ex.getMessage());
        }
        return result;
    }

    public static void main(String[] args) throws DivideByZeroException {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Hello, I can calculate the number of times one number is contained within the other.\nPlease type in the divident: ");
        Double divident = scanner.nextDouble();
        System.out.println("OK good, now type in the divisor: ");
        Double divisor = scanner.nextDouble();
        double result;
        result = div(divident, divisor);
        if (divisor != 0) System.out.println("The quotient is: " + result);
    }
}
