package chat;

import java.io.*;
import java.net.Socket;

public class Client{

    public static Socket socket;
    public static String clientsID;
    public static String recipientsID;
    public static String password;

    public static void main(String[] args) throws IOException{
            clientsID = args[0];
            password = args[1];
            recipientsID = args[2];
            try {
                socket = new Socket("localhost", 9090);
            }catch (IOException e){
                System.out.println("Unable to connect to the server. It may be caused by:");
                System.out.println("1. Server is offline");
                System.out.println("2. You are trying to connect to the wrong server, try other port or host");
            }
            Message login = new Message(clientsID, null, password);
            ClientReader reader = new ClientReader();
            reader.start();
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(socket.getOutputStream());
            objectOutputStream.writeObject(login);
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
            String inputText;
            while((inputText = bufferedReader.readLine()) != null){
                Message message = new Message(clientsID, recipientsID, inputText);
                objectOutputStream.writeObject(message);
            }
    }

    static class ClientReader extends Thread {
        @Override
        public void run(){
            try {
                Socket socket = Client.socket;
                ObjectInputStream objectInputStream = new ObjectInputStream(socket.getInputStream());

                while(objectInputStream.available() <= 0) {
                    Message message = (Message) objectInputStream.readObject();
                    System.out.println(message.sender + " : " + message.text);
                }
            } catch (IOException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}