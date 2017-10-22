package serialize;

import java.io.*;
import java.util.Iterator;

public class Tester {
    public static void main(String[] args) {
        String[] stringArray;
        Circular<String> circular = new Circular<>(String.class, 5);

        //Declaring array with some random stuff
        stringArray = new String[]{"I'm", "never", "gonna", "dance", "again", "the", "way", "I", "danced", "with", "you", "ohh", "ohh"};

        //Iterating over buffer to fill it with data from previous array
        for (int i = 0; i < stringArray.length; i++) {
            try {
                circular.put(stringArray[i]);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.print(stringArray[i] + " ");
            if (i != 0)
                circular.tail++;
            circular.tail %= circular.buffer.length;
        }
        System.out.print("\n");

        //Serializing Circular Buffer
        serialize(circular);

        //Sort of 'reseting' the Circular Buffer
        circular.head = 0;
        circular.tail = 3;
        for (int i = 0; i < 5; i++) {
            circular.add("lol");
            circular.tail++;
            circular.tail %= circular.buffer.length;
            System.out.print(circular.buffer[i] + " ");
        }
        System.out.print("\n");

        //Deserializing Circular Buffer
        circular = (Circular<String>) deserialize("CircularBuffer.ser");

        // #PROOF
        int i = 0;
        Iterator iterator = circular.iterator();
        while (iterator.hasNext()) {
            String value = (String) iterator.next();
            if(i<10)
                i++;
            else
                break;
            if (iterator.hasNext()) {
                System.out.print(value + ", ");
            } else {
                System.out.print(value);
            }
        }
    }

    // Serializing Circular Buffer
    private static boolean serialize(Object object){
        try(ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("CircularBuffer.ser"))){
            oos.writeObject(object);
            System.out.println("Serialization process finished with success");
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Serialization process finished but with no success");
            return false;
        }
    }

    // Retrieving serialized Circular Buffer
    private static Object deserialize(String s){
        try(ObjectInputStream ois = new ObjectInputStream(new FileInputStream("CircularBuffer.ser"))){
            return ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Deserialization process finished but with no success");
            return null;
        }
    }
}
