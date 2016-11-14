package start;

public class ComplexTest {
    public static void main(String[] args){
        System.out.print("This class will test the Complex.java, which is the implementation of complex numbers in java.");
        Complex a = new Complex();
        System.out.print("\nCreated first object 'a' that is equal to " + a.toString());
        Complex b = new Complex(-3.0, 4.0);
        System.out.print("\nCreated second object 'b' that is equal to " + b.toString());
        a.setRe(5.0);
        System.out.print("\n'a' real part is set to " + Complex.re(a));
        a.setIm(6.0);
        System.out.print("\n'a' imaginary part is set to " + Complex.im(a));
        System.out.print("\n'a' is now equal to " + a.toString());
        System.out.print("\n'b' was added to 'a', which is now equal to " + Complex.add(a,b).toString());
        System.out.print("\n'b' was subtracted from 'a', which is again equal to " + Complex.sub(a,b).toString());
        System.out.print("\n'a' was multiplayed by 'b' and now is equal to " + Complex.mul(a,b).toString());
        System.out.print("\n'a' was divided by 'b' and now is equal to " + Complex.div(a,b).toString());
        System.out.print("\nThe absolute value of 'a' is equal to " + Complex.abs(a));
        System.out.print("\nThe square of absolute value of 'a' is equal to " + Complex.sqrAbs(a));
        System.out.print("\nThe phase of 'a' is equal to " + Complex.phase(a));
    }
}
