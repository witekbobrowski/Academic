package start;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.geom.Arc2D;

public class Adder extends JFrame{

    private static JLabel resultLabel;
    private static JTextField aTextField;
    private static JTextField bTextField;

    public static void createAndShowGUI(){
        JFrame frame = new JFrame("Adder");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JPanel panel = new JPanel(new GridLayout(4,1));

        resultLabel = new JLabel("Result", SwingConstants.CENTER);
        JButton addButton = new JButton("Add");
        aTextField = new JTextField();
        bTextField = new JTextField();

        addButton.addActionListener(e -> {
            addAndDisplay();
        });

        frame.add(panel);
        panel.add(aTextField);
        panel.add(bTextField);
        panel.add(addButton);
        panel.add(resultLabel);

        frame.pack();
        frame.setSize(400, 300);
        frame.setVisible(true);
    }

    public static void addAndDisplay() throws NumberFormatException {
        try {
            String textFromAField = aTextField.getText();
            String textFromBField = bTextField.getText();
            double a = Double.parseDouble(textFromAField);
            double b = Double.parseDouble(textFromBField);
            double result = a + b;
            resultLabel.setText(String.valueOf(result));
        }catch(NumberFormatException ex){
            System.out.println("wrong input dude, use numbers...");
        } finally{
            System.out.println("moving on...");
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
                createAndShowGUI();
        });
    }
}