package start;
import java.math.*;

public class Complex
{
    private double re, im;


    public Complex(double r){
        re = r;
        im = 0;
    };
    public Complex(double real, double imag){
        re = real;
        im = imag;
    };
    public Complex(Complex c){
        c.re = re;
        c.im = im;
    };
    public Complex(String){

    };

    static Complex add(Complex a, Complex b){
        double real = a.re + b.re;
        double imag = a.im + b.im;
        return new Complex(real, imag);
    };   /* Zwraca sumę dwóch liczb zespolonych */

    static Complex sub(Complex a, Complex b){
        double real = a.re - b.re;
        double imag = a.im - b.im;
        return new Complex(real, imag);
    };   /* Zwraca różnice dwóch liczb zespolonych */

    static Complex mul(Complex a, Complex b) {
        double real = a.re * b.re - a.im * b.im;
        double imag = a.re * b.im + a.im * b.re;
        return new Complex(real , imag)
    };   /* Zwraca iloczyn dwóch liczb zespolonych */

    static Complex div(Complex a, Complex b){
        double real = (a.re * b.re + a.im * b.im) / (b.re * b.re + b.im * b.im);
        double imag = (a.im * b.re - a.re * b.im) / (b.re * b.re + b.im * b.im);
        return new Complex(real, imag);
    };  /* Zwraca iloraz dwóch liczb zespolonych */

    static double abs(Complex a){
        double absoluteValue = Math.hypot(a.re, a.im);
        return absoluteValue;
    }/* Zwraca moduł liczby zespolonej */

    static double phase(Complex a){
        double phase = Math.atan2(a.im, a.re);
        return phase;
    };  /* Zwraca faze liczby zespolonej */

    static double sqrAbs(Complex){
        double absoluteSquare = Math.hypot(a.re, a.im)^2;
        return absoluteSquare;
    };/* Zwraca kwadrat modułu liczby zespolonej */

    static double re(Complex a){
        double real = a.re;
        return real;
    };  /* Zwraca część rzeczywistą liczby zespolonej */

    static double im(Complex a){
        double imag = a.im;
        return imag;
    };  /*Zwraca część urojoną liczby zespolonej */

    /* Poniższe metody modyfikuja aktualny obiekt i zwracają 'this' */

    Complex add(Complex);   // Dodaje liczbę zespoloną
    Complex sub(Complex);   // Odejmuje liczbę zespoloną
    Complex mul(Complex);   // Mnoży przez liczbę zespoloną
    Complex div(Complex);   // Dzieli przez liczbę zespoloną
    double abs();
    double sqrAbs();
    double re();
    double im();

    String toString();
    /* Zwraca String z zapisaną
        liczbą zespoloną formacie "-1.23+4.56i" */

    static Complex valueOf(String);
    /* Zwraca liczbę zespolona o wartości podanej
        w argumencie w formacie "-1.23+4.56i" */

    void setRe(double);
    /* Przypisuje podaną wartość części rzeczywistej */

    void setIm(double);
    /* Przypisuje podaną wartość części urojonej */

    void setVal(Complex);
    void setVal(double, double);
    /* Przypisuje podaną wartość */
}