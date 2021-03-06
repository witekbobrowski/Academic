package start;
public class Complex
{
    private double re, im;

    public Complex(){
        re = 0;
        im = 0;
    }
    public Complex(double r){
        re = r;
        im = 0;
    }
    public Complex(double real, double imag){
        re = real;
        im = imag;
    }
    public Complex(Complex z){
        re = z.re;
        im = z.im;
    }
    public Complex(String s) throws NumberFormatException{
        String[] parts = s.split("\\+|i");
        re = Double.parseDouble(parts[0]);
        im = Double.parseDouble(parts[1]);
    }

    public static Complex add(Complex a, Complex b){
        double real = a.re + b.re;
        double imag = a.im + b.im;
        return new Complex(real, imag);
    }   /* Zwraca sumę dwóch liczb zespolonych */

    public static Complex sub(Complex a, Complex b){
        double real = a.re - b.re;
        double imag = a.im - b.im;
        return new Complex(real, imag);
    }   /* Zwraca różnice dwóch liczb zespolonych */

    public static Complex mul(Complex a, Complex b) {
        double real = a.re * b.re - a.im * b.im;
        double imag = a.re * b.im + a.im * b.re;
        return new Complex(real , imag);
    }   /* Zwraca iloczyn dwóch liczb zespolonych */

    public static Complex div(Complex a, Complex b){
        double real = (a.re * b.re + a.im * b.im) / (b.re * b.re + b.im * b.im);
        double imag = (a.im * b.re - a.re * b.im) / (b.re * b.re + b.im * b.im);
        return new Complex(real, imag);
    }  /* Zwraca iloraz dwóch liczb zespolonych */

    public static double abs(Complex a){
        double absoluteValue = Math.hypot(a.re, a.im);
        return absoluteValue;
    }   /* Zwraca moduł liczby zespolonej */

    public static double phase(Complex a){
        double phase = Math.atan2(a.im, a.re);
        return phase;
    }  /* Zwraca faze liczby zespolonej */

    public static double sqrAbs(Complex a){
        double absolute = abs(a);
        double absoluteSquare = absolute * absolute;
        return absoluteSquare;
    }   /* Zwraca kwadrat modułu liczby zespolonej */

    public static double re(Complex a){
        double real = a.re;
        return real;
    }  /* Zwraca część rzeczywistą liczby zespolonej */

    public static double im(Complex a){
        double imag = a.im;
        return imag;
    }  /*Zwraca część urojoną liczby zespolonej */

    /* Poniższe metody modyfikuja aktualny obiekt i zwracają 'this' */

    public Complex add(Complex b){
        Complex a = this;
        this.re = a.re + b.re;
        this.im = a.im + b.im;
        return this;
    }   // Dodaje liczbę zespoloną

    public Complex sub(Complex b){
        Complex a = this;
        this.re = a.re - b.re;
        this.im = a.im - b.im;
        return this;
    }   // Odejmuje liczbę zespoloną

    public Complex mul(Complex b){
        Complex a = this;
        this.re = a.re * b.re - a.im * b.im;
        this.im = a.re * b.im + a.im * b.re;
        return this;
    }   // Mnoży przez liczbę zespoloną

    public Complex div(Complex b){
        Complex a = this;
        this.re = (a.re * b.re + a.im * b.im) / (b.re * b.re + b.im * b.im);
        this.im = (a.im * b.re - a.re * b.im) / (b.re * b.re + b.im * b.im);
        return this;
    }   // Dzieli przez liczbę zespoloną

    public double abs(){
        return Math.hypot(re, im);
    }
    public double sqrAbs(){
        return abs()*abs();
    }
    public double re(){
        return re;
    }
    public double im(){
        return im;
    }
    @Override
    public String toString(){
        if (this.im>=0) return Double.toString(re) + "+" + Double.toString(im) + "i";
        else return Double.toString(re) + Double.toString(im) + "i";
    }   /* Zwraca String z zapisaną liczbą zespoloną formacie "-1.23+4.56i" */

    public static Complex valueOf(String s)throws NumberFormatException{
        String[] parts = s.split("\\+|i");
        return new Complex(Double.parseDouble(parts[0]),Double.parseDouble(parts[1]));
    }/* Zwraca liczbę zespolona o wartości podanej w argumencie w formacie "-1.23+4.56i" */

    public void setRe(double real){
        this.re = real;
    }   /* Przypisuje podaną wartość części rzeczywistej */

    public void setIm(double imag) {
        this.im = imag;
    }   /* Przypisuje podaną wartość części urojonej */

    public void setVal(Complex z){
        this.re = z.re();
        this.im = z.im();
    }
    public void setVal(double real, double imag) {
        this.re = real;
        this.im = imag;
    }   /* Przypisuje podaną wartość */
}