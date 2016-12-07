package mandelbrot;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;

public class Mandelbrot{

    private BufferedImage buffer;
    public static final int width = 800;
    public static final int height = 600;
    public static final int iterations = 100;

    public void createGUI(){

        buffer = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        renderMandelbrot(200, 0, 200);
        JFrame frame = new JFrame("Mandelbrot Set");
        frame.setPreferredSize(new Dimension(width, height));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.add(new JLabel(new ImageIcon(buffer))).addMouseListener(new MouseListener(){
            int ax = 0, ay = 0, bx = 0, by = 0;
            int selectX, selectY;
            int moveX, moveY;
            int frameField = width * height;
            int selectedField = 0;
            int ratio = 0;

            public void mouseClicked(MouseEvent clicked){};
            public void mouseEntered(MouseEvent entered){}
            public void mousePressed(MouseEvent pressed){
                ax = pressed.getX();
                ay = pressed.getY();
            }
            public void mouseReleased(MouseEvent released){
                bx = released.getX();
                by = released.getY();
                if (ax > bx) {
                    selectX = ax - bx;
                    moveX = ax - (selectX/2);
                }
                if (bx > ax) {
                    selectX = bx - ax;
                    moveX = bx - (selectX/2);
                }
                if (ay > by) {
                    selectY = ay - by;
                    moveY = ay - (selectY/2);
                }
                if (by > ay) {
                    selectY = by - ay;
                    moveY = by - (selectY/2);
                }
                System.out.println(selectX + " " + selectY);
                selectedField = selectX * selectY;
                ratio = frameField/selectedField;
                System.out.println("Multiply scale " + ratio + " times, and center image at " + moveX + " " + moveY);
                renderMandelbrot(moveX, moveY, 200*ratio);
            }
            public void mouseExited(MouseEvent exited){}

        });
        frame.setVisible(true);
    }

    public void renderMandelbrot(int moveX, int moveY, int scale){
        for(int x = 0 ; x < width ; x++)
            for(int y = 0 ; y < height ; y++){
                int color = calculateColor(new Complex((x - moveX- width/2.)/scale, (y - moveY - height/2.)/scale));
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

    public static void main(String[] args){
        Mandelbrot lol = new Mandelbrot();
        lol.createGUI();
    }
}