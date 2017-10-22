package start;

import java.io.*;
import java.util.Scanner;

public class PrintFile {
    public static void main(String[] args) throws IOException {

        Scanner scanner = new Scanner(System.in);
        System.out.println("Hello there, which file would you like me to print for you?\n");
        String fileName = scanner.nextLine();

        BufferedReader inputStream = null;
        PrintStream printStream = new PrintStream(System.out);

        try{
            inputStream = new BufferedReader(new FileReader(fileName));
            String line;
            int i = 0;
            while ((line = inputStream.readLine()) != null){
                i++;
                printStream.println(i + ". "+ line);
            }
        }catch(FileNotFoundException ex){
            System.out.println("Sorry bro but '" + fileName + "' does not exist.");
        } finally {
            if(inputStream != null) inputStream.close();
            printStream.flush();
        }
    }
}