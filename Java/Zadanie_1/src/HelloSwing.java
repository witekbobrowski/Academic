import javax.swing.*;

public class HelloSwing {

    public static void createAndShowGUI(){
        JFrame frame = new JFrame("HelloSwing");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JLabel label = new JLabel("HELLO SWING :)", SwingConstants.CENTER);
        frame.getContentPane().add(label);
        frame.pack();
        frame.setSize(400, 300);
        frame.setVisible(true);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI();
            }
        });
    }
}