package balls;

import javax.swing.*;
import java.awt.*;
import java.util.Random;

    public class Ball extends JPanel implements Runnable{

        public Ball(int radius){
            this.radius = radius;
            new Thread(this).start();
        }

        public int xSpeed = 1;
        public int ySpeed = 1;
        public int radius;

        volatile boolean stopped = false;
        volatile boolean running = true;

        Dimension panelDimensions = getParent().getSize();

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

        while(!stopped){
            if(running){
                try{
                    Thread.sleep(30);
                }
                catch(InterruptedException e){
                    System.err.println("InterruptedException");
                }
                move();
                repaint();
            }
        }
    }

    void kill(){
        stopped = true;
    }

    public void restart(){
        if(running == false)
            running = true;
        else
            running = false;
    }

    @Override
    public void paint(final Graphics g){
        super.paint(g);
        g.setColor(Color.YELLOW);
        g.fillOval(0, 0, 2*radius, 2*radius);
    }

}
