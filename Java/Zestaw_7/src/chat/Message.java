package chat;

import java.io.Serializable;

public class Message implements Serializable {

    private static final long serialVersionUID = 4815162342L;
    public String sender;
    public String recipient;
    public String text;

    public Message(String sender, String recipient, String input){
        this.sender = sender;
        this.recipient = recipient;
        this.text = input;
    }
}
