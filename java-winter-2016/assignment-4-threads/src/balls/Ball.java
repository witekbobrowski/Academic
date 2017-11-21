package balls;
import javax.swing.*;
import java.awt.*;
import java.util.Random;

public class Ball extends JComponent implements Runnable{

    public static final long serialVersionUID = -48151612342L;
    private int x, y;
    private int xSpeed = 0;
    private int ySpeed = 0;
    private int radius;
    private Color color;
    private JPanel panel;
    private Dimension ballSize;
    volatile boolean running = true;
    Random generator = new Random();

    public Ball(JPanel panel) {
        this.panel = panel;
        this.radius = generator.nextInt(20) + 5;
        while(this.xSpeed == 0) this.xSpeed = generator.nextInt(5) - 2;
        while(this.ySpeed == 0) this.ySpeed = generator.nextInt(5) - 2;
        this.color = Color.getHSBColor(0.65f * (xSpeed * ySpeed)/(xSpeed + ySpeed), 0.6f, 1.0f);
        this.ballSize = new Dimension(radius * 2, radius * 2);
        this.setSize(ballSize);
        new Thread(this).start();
    }

    private synchronized void move() {
        this.x = getX();
        this.y = getY();
        //Bounce off the side walls
        if (x + xSpeed < 0 || x + xSpeed + 2 * radius > panel.getWidth()) xSpeed *= -1;
        //Bounce off the floor or ceiling
        if (y + ySpeed < 0 || y + ySpeed + 2 * radius > panel.getHeight()) ySpeed *= -1;
        this.x += xSpeed;
        this.y += ySpeed;
        setLocation(x, y);
    }

    @Override
    public void run() {
        this.x = generator.nextInt(panel.getWidth() - 2*radius);
        this.y = generator.nextInt(panel.getHeight() - 2*radius);
        setLocation(this.x, this.y);
        while (true) {
            if (running) {
                try {
                    Thread.sleep(25);
                } catch (InterruptedException e) {
                    System.err.println("InterruptedException");
                }
                if(inBox()) {
                    this.enter();
                } else
                    this.move();
                repaint();
            }
        }
    }

    private void enter(){
        synchronized (Ball.class) {
            this.exit();
        }
    }

    private synchronized void exit(){
        while(inBox()){
            try {
                Thread.sleep(25);
            } catch (InterruptedException e) {
                System.err.println("InterruptedException");
            }
            move();
        }
    }

    private boolean inBox(){
        if((this.getX() + this.getWidth()) >= 320 && this.getX() <= 480){
            if ((this.getY() + this.getHeight())>= 210 && this.getY() <= 330){
                return true;
            }
            else
                return false;
        }
        else
            return false;
    }

    protected void kill() {
        this.running = false;
    }

    protected void restart() {
        this.running = true;
    }

    @Override
    public void paintComponent( Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g.create();
        g2d.setColor(color);
        g2d.fillOval(0, 0, radius*2, radius*2);
    }
}
