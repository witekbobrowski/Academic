import java.util.Scanner;

public class Palette {

    public native void printText(Color c);

    static {
        System.loadLibrary("Palette");
    }

    public static void main(String[] args) {
        clearTerminal();
        Palette palette = new Palette();
        palette.printText(Color.BLUE);
    }

    protected static void clearTerminal(){
        final String ANSI_CLS = "\u001b[2J";
        final String ANSI_HOME = "\u001b[H";
        System.out.print(ANSI_CLS + ANSI_HOME);
        System.out.flush();
    }

}

enum Color{

    BLACK(0.0, 0.0, 0.0),
    WHITE(1.0, 1.0, 1.0),
    GRAY(0.74, 0.74, 0.74),
    RED(1.0, 0.0, 0.0),
    GREEN(0.0, 1.0, 0.0),
    BLUE(0.0, 0.0, 1.0),
    YELLOW(1.0, 1.0, 0.0),
    CYAN(0.0, 1.0, 1.0),
    MAGENTA(1.0, 0.0, 1.0);

    public double r, g, b;

    Color(Double r, Double g, Double b){
        this.r = r;
        this.g = g;
        this.b = b;
    }

    boolean compare(Double r, Double g, Double b){
        if (this.r == r && this.g == g && this.b == b) {
            return true;
        }else return false;
    }

    public static Color name(double r, double g, double b){
        for(Color color: Color.values()){
            if (color.r == r && color.g == g && color.b == b)
                return color;
        }
        return null;
    }

}