package chat;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

class ClientSocket extends Thread {

    protected Socket socket;
    private final ClientSocket[] clientSockets;
    ObjectInputStream objectInputStream;
    ObjectOutputStream objectOutputStream;

    public ClientSocket(Socket clientSocket, ClientSocket[] clientSockets) {
        this.socket = clientSocket;
        this.clientSockets = clientSockets;
    }

    @Override
    public void run() {

        try {
            objectInputStream = new ObjectInputStream(socket.getInputStream());
            objectOutputStream = new ObjectOutputStream(socket.getOutputStream());
            while(true) {
                while (objectInputStream.available() <= 0) {
                    Message message = (Message) objectInputStream.readObject();
                    System.out.println("sending message from client : " + message.sender + " to client : " + message.recipient);
                    clientSockets[message.recipient].objectOutputStream.writeObject(message);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            return;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }


    }
}