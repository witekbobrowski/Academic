package mandelbrot;

import javax.swing.*;

public class Mandelbrot {
    public static void createAndShowGUI() {
        JFrame frame = new JFrame("Mandelbrot");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 600);
        frame.setVisible(true);
    }
    public static void main(String[] args){
        createAndShowGUI();
    }
}
