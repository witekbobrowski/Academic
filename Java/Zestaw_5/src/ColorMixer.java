public enum ColorMixer {

    ADD{
        public Color mix(Color a, Color b){
            return Color.name(a.r + b.r, a.g + b.g, a.b + b.b);
        }
    },
    
    MUL{
        public Color mix(Color a, Color b){
            return Color.name(a.r * b.r, a.g * b.g, a.b * b.b);
        }
    },

    AVERAGE{
        public Color mix(Color a, Color b){
            return Color.name((a.r + b.r)/2, (a.g + b.g)/2, (a.b + b.b)/2);
        }
    };

    public abstract Color mix(Color a, Color b);

    public static void main(String[] args){
        System.out.println("Mixing colors using method 'ADD' ");
        System.out.println("---------------------------------");
        ColorMixer colorMixer = ColorMixer.ADD;
        for (Color a: Color.values()){
            for (Color b: Color.values()){
                Color mixedColor = colorMixer.mix(a, b);
                if (mixedColor != null){
                    System.out.println(a + " mixed with " + b + " gives " + mixedColor);
                }
            }
        }
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
