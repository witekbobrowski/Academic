package chat;

import java.io.*;
import java.net.Socket;

public class Client{

    public static Socket socket;
    public static int clientsID;
    public static int recipientsID;

    public static void main(String[] args) throws IOException{
            clientsID = new Integer(args[0]);
            recipientsID = new Integer(args[1]);
            if(serverOnlineCheck()){
                socket = new Socket("localhost", 9090);
            }else return;
            ClientReader reader = new ClientReader();
            reader.start();
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(socket.getOutputStream());
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
            String inputText;
            while((inputText = bufferedReader.readLine()) != null){
                Message message = new Message(clientsID, recipientsID, inputText);
                objectOutputStream.writeObject(message);
            }
    }

    public static boolean serverOnlineCheck() {
        try (Socket socket = new Socket("localhost", 9090)) {
            return true;
        } catch (IOException ex) {
            System.out.println("Unable to connect to the server. It may be caused by:");
            System.out.println("1. Server is offline");
            System.out.println("2. You are trying to connect to the wrong server, try other port or host");
        }
        return false;
    }

    static class ClientReader extends Thread {

        ClientReader() throws IOException{
        }

        @Override
        public void run(){
            try {
                Socket socket = Client.socket;
                ObjectInputStream objectInputStream = new ObjectInputStream(socket.getInputStream());

                while(objectInputStream.available() <= 0) {
                    Message message = (Message) objectInputStream.readObject();
                    System.out.println(message.sender + " : " + message.text);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
    }
}