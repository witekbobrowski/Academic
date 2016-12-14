package balls;

import javax.swing.*;
import java.awt.*;
import java.util.Random;

public class Ball extends JPanel implements Runnable{

    public Ball(int radius, JPanel panel){
        this.radius = radius;
	this.panel = panel;
        new Thread(this).start();
    }

    public int xSpeed = 1;
    public int ySpeed = 1;
    public int radius;
    public JPanel panel;

    volatile boolean stopped = false;

    Dimension panelDimensions = panel.getSize();

    public void move(){
        int x = getX();
        int y = getY();
        //Bounce off the side walls
        if(x + xSpeed < 0 || x + xSpeed + 2*radius > panelDimensions.width) xSpeed *= -1;
        //Bounce off the floor or ceiling
        if(y + ySpeed < 0 || y + ySpeed + 2*radius > panelDimensions.height) ySpeed *= -1;

        x += xSpeed;
        y += ySpeed;

        setLocation(x, y);
    }

    public void run() {
        Random generator = new Random();
        int randomX = generator.nextInt(panelDimensions.width) + 1;
        int randomY = generator.nextInt(panelDimensions.height) + 1;
        int x = randomX;
        int y = randomY;
        setLocation(x, y);

        if (stopped) {
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        } else {
            move();
            repaint();
        }
    }

    public void kill(){
        stopped = true;
    }

    public void restart(){
        if(stopped == true){
            stopped = false;
        }
    }

    @Override
    public void paint(final Graphics g){
        super.paint(g);
        g.setColor(Color.YELLOW);
        g.fillOval(0, 0, 2*radius, 2*radius);
    }

}
