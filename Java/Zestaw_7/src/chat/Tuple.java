package chat;

public class Tuple<A, B, C> {

    public final A password;
    public B socket;
    public C messageList;

    public Tuple(A password, B socket, C messageList) {
        this.password = password;
        this.socket = socket;
        this.messageList = messageList;
    }
}
