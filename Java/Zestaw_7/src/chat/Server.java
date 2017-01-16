package chat;

import java.io.*;
import java.net.*;

public class Server{

    private static final int port = 9090;
    private static final int clientsLimit = 50;
    private static final ClientSocket[] clientSockets = new ClientSocket[clientsLimit];

    public static void main(String[] args) {

        try(ServerSocket serverSocket = new ServerSocket(port, clientsLimit)) {
            Socket socket;
            while (true) {
                socket = serverSocket.accept();
                int i = 0;
                for (; i < clientsLimit; i++) {
                    if (clientSockets[i] == null) {
                        (clientSockets[i] = new ClientSocket(socket, clientSockets)).start();
                        System.out.println("Client have joined the server. Assigned ID: " + i);
                        break;
                    }
                }
                if (i == clientsLimit) {
                    ObjectOutputStream objectOutputStream = new ObjectOutputStream(socket.getOutputStream());
                    Message maxClientsReachedError = new Message(i, "Sorry, the server is currently full.");
                    objectOutputStream.writeObject(maxClientsReachedError);
                    objectOutputStream.close();
                    socket.close();
                }
            }
        } catch (IOException e){
            e.printStackTrace();
        }



    }

    static class ClientSocket extends Thread {

        private Socket socket;
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
                        System.out.print("\nSending message from client : " + message.sender + " to client : " + message.recipient);
                        try {
                            clientSockets[message.recipient].objectOutputStream.writeObject(message);
                        } catch (NullPointerException e){
                            System.out.print("| ERROR : message undelivered...");
                        }
                    }
                }
            } catch (IOException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}
