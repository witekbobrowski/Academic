package balls;

import javax.swing.*;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.*;

public class Playground extends JFrame{

    static JPanel playgroundPanel;
    static JPanel interfacePanel;

    public static void main(String[] args) {

        JFrame frame = new JFrame("Playground");
        playgroundPanel = new JPanel();
        interfacePanel = new JPanel();
        JButton button = new JButton("Add Ball");
        String[] comboOptions = {"A", "B", "C", "D", "E", "F"};
        JComboBox<String> comboBox = new JComboBox<>(comboOptions);
        JLabel comboLabel = new JLabel("Choose box functionality");


        button.addActionListener(event -> {
            addBall();
        });

        //frame.add(playgroundPanel);
        frame.add(interfacePanel, BorderLayout.SOUTH);
        interfacePanel.add(button);
        interfacePanel.add(comboLabel);
        interfacePanel.add(comboBox);
        playgroundPanel.setBackground(Color.gray);
        frame.setPreferredSize(new Dimension(800, 600));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

    public static void addBall() throws NullPointerException{
        try{
            Ball ball = new Ball(15);
            ball.addMouseListener(new MouseAdapter(){
                @Override
                public void mouseClicked(MouseEvent e){
                    if(e.getButton() == MouseEvent.BUTTON1)
                        ball.kill();
                    else if(e.getButton() == MouseEvent.BUTTON3)
                        ball.restart();
                }
            });
            playgroundPanel.add(ball);
            playgroundPanel.revalidate();
        }catch(NullPointerException exeption){
	    System.err.println("NullPointerException");
        }
    }
}
