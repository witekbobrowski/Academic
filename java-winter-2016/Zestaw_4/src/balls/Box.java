package balls;

import javax.swing.*;
import java.awt.*;

public class Box extends JComponent implements Runnable {

    public static final long serialVersionUID = -12342481516L;
    private JPanel panel;
    private Dimension boxSize;

    public Box(JPanel panel){
        this.boxSize = new Dimension(160, 120);
        this.panel = panel;
        this.setSize(boxSize);
        new Thread(this).start();
    }

    @Override
    public void run() {
        setLocation(((panel.getWidth()/2) - (boxSize.width)/2), ((panel.getHeight()/2) - (boxSize.height)/2));
        System.out.println(panel.getWidth() +" "+ panel.getHeight());
        while (true) {
            try {
                Thread.sleep(25);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            setLocation(((panel.getWidth()/2) - (boxSize.width)/2), ((panel.getHeight()/2) - (boxSize.height)/2));
            repaint();
        }
    }

    @Override
    public void paintComponent( Graphics b) {
        super.paintComponent(b);
        Graphics2D b2d = (Graphics2D) b.create();
        Stroke oldStroke = b2d.getStroke();
        b2d.setStroke(new BasicStroke(5));
        b2d.setColor(Color.DARK_GRAY);
        b2d.drawRect(0, 0, this.getWidth(), this.getHeight());
        b2d.setStroke(oldStroke);
    }
}