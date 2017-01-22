package balls;

import javax.swing.*;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.*;
import java.util.LinkedList;

public class Playground extends JFrame{

    static JPanel playgroundPanel;
    static JPanel interfacePanel;
    static JComboBox<String> comboBox;
    static LinkedList<Ball> balls;

    public static void main(String[] args) {

        JFrame frame = new JFrame("Playground");
        playgroundPanel = new JPanel();
        interfacePanel = new JPanel();
        JButton button = new JButton("Add Ball");
        String[] comboOptions = {"A", "B", "C", "D", "E", "F"};
        comboBox = new JComboBox<>(comboOptions);
        balls = new LinkedList<>();
        JLabel comboLabel = new JLabel("Choose box functionality");
        button.addActionListener(event -> addBall());
        frame.add(playgroundPanel);
        frame.add(interfacePanel, BorderLayout.SOUTH);
        interfacePanel.add(button);
        interfacePanel.add(comboLabel);
        interfacePanel.add(comboBox);
        frame.setPreferredSize(new Dimension(800, 600));
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
        frame.setResizable(false);
        Box box = new Box(playgroundPanel);
        playgroundPanel.add(box);
    }

    public static void addBall() throws NullPointerException{
        try{
            Ball ball = new Ball(playgroundPanel);
            playgroundPanel.add(ball);
            ball.addMouseListener(new MouseAdapter(){
                @Override
                public void mouseClicked(MouseEvent e){
                    if(e.getButton() == MouseEvent.BUTTON1) {
                        System.out.println("click");
                        ball.kill();
                    } else if(e.getButton() == MouseEvent.BUTTON3) {
                        System.out.println("click");
                        ball.restart();
                    }
                }
            });
        }catch(NullPointerException exception){
	        exception.printStackTrace();
        }
    }
}