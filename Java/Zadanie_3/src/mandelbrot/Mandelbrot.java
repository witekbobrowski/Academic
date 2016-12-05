package mandelbrot;

import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;

public class Mandelbrot extends JComponent{

    public static void main(String[] args){
        Mandelbrot lol = new Mandelbrot();
        lol.createGUI();
    }

    private BufferedImage buffer;
    public static final int width = 1280;
    public static final int height = 720;
    public static final int iterations = 400;
    public static final double scale = 300;

    public void createGUI(){

        buffer = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        renderMandelbrot();
        JFrame frame = new JFrame("Mandelbrot Set");
        frame.setPreferredSize(new Dimension(width, height));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setResizable(true);
        frame.getContentPane().add(this);
        frame.pack();
        frame.add(new JLabel(new ImageIcon(buffer)));
        frame.setVisible(true);
    }

    public void renderMandelbrot(){
        for(int x = 0 ; x < width ; x++)
            for(int y = 0 ; y < height ; y++){
                int color = calculateColor(new Complex((x - width/2.)/scale, (y - height/2.)/scale));
                buffer.setRGB(x, y, color);
            }
    }

    public int calculateColor(Complex startingPoint){

        Complex c = new Complex(startingPoint);
        int i = 0;
        for(;i < iterations; i++){
            c = Complex.add(Complex.mul(c,c), (startingPoint));
            if(c.abs() > 4) break;
        }
        if(i == iterations) return 0x00000000;
        return Color.HSBtoRGB(0.95f * i/iterations, 0.6f, 1.0f);
    }
}