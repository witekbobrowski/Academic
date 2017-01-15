package chat;

import java.io.Serializable;

public class Message implements Serializable {

    private static final long serialVersionUID = 4815162342L;
    public int sender;
    public int recipient;
    public String text;

    public Message(int recipient, String input){
        this.recipient = recipient;
        this.text = input;
    }

    public Message(int sender, int recipient, String input){
        this.sender = sender;
        this.recipient = recipient;
        this.text = input;
    }
}
