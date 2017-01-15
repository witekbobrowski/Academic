package chat;

import java.io.*;
import java.net.*;

public class Server{

    private static final int port = 9090;
    private static final int maxClientsCount = 50;
    private static final ClientSocket[] clientSockets = new ClientSocket[maxClientsCount];

    public static void main(String[] args) {

        ServerSocket serverSocket = null;
        Socket socket;

        try {
            serverSocket = new ServerSocket(port, maxClientsCount);
        } catch (IOException e) {
            e.printStackTrace();
        }
        while (true) {
            try {
                socket = serverSocket.accept();
                int i = 0;
                for (; i < maxClientsCount; i++) {
                    if (clientSockets[i] == null) {
                        (clientSockets[i] = new ClientSocket(socket, clientSockets)).start();
                        System.out.println("Client have joined the server. Assigned ID: " + i);
                        break;
                    }
                }
                if (i == maxClientsCount) {
                    ObjectOutputStream objectOutputStream = new ObjectOutputStream(socket.getOutputStream());
                    Message maxClientsReachedError = new Message(i, "Sorry, the server is currently full.");
                    objectOutputStream.writeObject(maxClientsReachedError);
                    objectOutputStream.close();
                    socket.close();
                }
            } catch (IOException e) {
                System.out.println("I/O error: " + e);
            }
        }
    }


}
