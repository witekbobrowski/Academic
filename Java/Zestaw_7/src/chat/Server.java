package chat;

import java.io.*;
import java.net.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Objects;

public class Server {

    private static final int port = 9090;
    private static HashMap<String, Tuple<String, ClientSocket, LinkedList<Message>>> users;

    public static void main(String[] args) {
        users = new HashMap<>();
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("log: Server is up and running!");
            Socket socket;
            while (true) {
                socket = serverSocket.accept();
                System.out.print("log: Someone is trying to join the server...");
                ClientValidator validator = new ClientValidator(socket, users);
                validator.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Serializing HashMap which contains logins and passwords... yeah i know, shouldn't have said that.
    private static boolean serializeHashMap(Object object){
        try(ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("super_secret_file.ser"))){
            oos.writeObject(object);
            System.out.println("log: Serialization process finished with success");
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("log: Serialization process finished but with no success");
            return false;
        }
    }

    // Retrieving serialized HashMap
    private static Object deserializeHashMap(){
        try(ObjectInputStream ois = new ObjectInputStream(new FileInputStream("super_secret_file.ser"))){
            return ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("log: Deserialization process finished but with no success");
            return null;
        }
    }

    // I am here to validate any user that tries to log in
    static class ClientValidator extends Thread {

        private String user;
        private Socket socket;
        private ClientSocket clientSocket;
        private ObjectInputStream objectInputStream;
        private ObjectOutputStream objectOutputStream;
        private Tuple<String, ClientSocket, LinkedList<Message>> userInfo;
        private HashMap<String, Tuple<String, ClientSocket, LinkedList<Message>>> users;

        private ClientValidator(Socket socket, HashMap<String, Tuple<String, ClientSocket, LinkedList<Message>>> users) {
            this.socket = socket;
            this.users = users;
        }

        @Override
        public void run() {
            System.out.print("validating user...\n");
            try{
                objectInputStream = new ObjectInputStream(socket.getInputStream());
                objectOutputStream = new ObjectOutputStream(socket.getOutputStream());
                while (true) {
                    while (objectInputStream.available() <= 0) {
                        Message message = (Message) objectInputStream.readObject();
                        // All the knowledge I gained during my short life, I shall pass to my baby brother ClientSocket
                        clientSocket = new ClientSocket(objectInputStream, objectOutputStream, users);
                        user = message.sender;
                        clientSocket.setName(user);
                        clientSocket.start();
                        // If the validation process went ok I will die...
                        if (validateUser(user, message.text, clientSocket)) {
                            userInfo = users.get(user);
                            clientSocket.objectOutputStream.writeObject(new Message("server", user, "correct"));
                            LinkedList<Message> buffer = userInfo.messageList;
                            if(buffer.size() > 0) System.out.println("log: " + buffer.size() + " messages were waiting for " + user + " and have been now sent to him");
                            while (!buffer.isEmpty()) {
                                clientSocket.objectOutputStream.writeObject(buffer.removeFirst());
                            }
                            return; // IM NEVER GONNA DANCE AGAIN, THEY WAY I DANCED WITH YOU...
                        } else
                            clientSocket.objectOutputStream.writeObject(new Message("server", user, "incorrect"));
                    }
                }
            } catch (IOException | ClassNotFoundException e) {
                System.out.println("log: " + user + " have disconnnected from the server");
            }
        }

        // I will validate, if a user this is trying to log in is in the data base
        // if not, i will put him in there!
        private boolean validateUser(String user, String password, ClientSocket socket) {
            Tuple<String, ClientSocket, LinkedList<Message>> userInfo = users.get(user);
            if (userInfo != null) {
                // so you are saying we know each other?
                if (Objects.equals(userInfo.password, password)) {
                    // sup fam!
                    userInfo.socket = socket;
                    System.out.println("log: " + user + " joined the server succesfully!");
                    return true;
                } else {
                    // Congratulations, you just played yourself
                    System.out.println("log: " + user + " failed to join the server, he used the wrong password.");
                    return false;
                }
            } else {
                // nice to meet you, I'm Trent by the way
                users.put(user, new Tuple<>(password, socket, new LinkedList<>()));
                System.out.println("log: " + user + " joined the server succesfully, and he is here for the first time!");
                return true;
            }
        }
    }

    // I'm ClientValidators little brother, I will take care of all your messages!
    static class ClientSocket extends Thread {

        private String user;
        private String recipient;
        private ObjectInputStream objectInputStream;
        private ObjectOutputStream objectOutputStream;
        private Tuple<String, ClientSocket, LinkedList<Message>> recipientInfo;
        private HashMap<String, Tuple<String, ClientSocket, LinkedList<Message>>> users;

        private ClientSocket(ObjectInputStream ois, ObjectOutputStream oos, HashMap<String, Tuple<String, ClientSocket, LinkedList<Message>>> users) {
            this.users = users;
            this.objectInputStream = ois;
            this.objectOutputStream = oos;
        }

        @Override
        public void run() {
            user = this.getName();
            try {
                while (true) {
                    // here I'm waiting for new messages to arrive
                    while (objectInputStream.available() <= 0) {
                        Message message = (Message) objectInputStream.readObject();
                        // Ok i got it!
                        recipient = message.recipient;
                        // Public chatting...
                        if (Objects.equals(recipient, "Chat")) {
                            System.out.print("\nlog: " + user + " sent message to public chat");
                            for (HashMap.Entry<String, Tuple<String, ClientSocket, LinkedList<Message>>> entry : users.entrySet()) {
                                recipientInfo = entry.getValue();
                                try {
                                    if(recipientInfo.socket.isAlive())
                                        recipientInfo.socket.objectOutputStream.writeObject(message); // They should have it by now!
                                } catch (NullPointerException e){
                                    System.out.print(" but something went wrong.");
                                }
                            }
                        // Private chatting... see? I can do all of it!
                        } else {
                            System.out.print("\nlog: " + user + " sent message to " + recipient); // you bet baby
                            try {
                                if(users.containsKey(recipient)){
                                    recipientInfo = users.get(recipient);
                                    if (recipientInfo.socket.isAlive()) {
                                        recipientInfo.socket.objectOutputStream.writeObject(message); // sending the message... easy fam, dat s**t too easy
                                        System.out.print(" with success.");
                                    } else {
                                        System.out.print(" but " + recipient + " is offline so the message is stored."); // oh i see
                                        recipientInfo.messageList.offer(message);
                                    }
                                }
                                else{
                                    System.out.print(" but he failed because " + recipient + " does not exists"); // dont play me next time aight?!
                                }
                            } catch (IOException | NullPointerException e) {
                                System.out.print(" but something went wrong.");
                            }
                        }
                    }
                }
            } catch (IOException | ClassNotFoundException e) {
                System.out.println("\nlog: " + user + " have disconnnected from the server"); // leaving me so soon?
                return; // I'm out
            }
        }
    }
}