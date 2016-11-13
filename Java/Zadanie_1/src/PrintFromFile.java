import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;

public class PrintFromFile {
    public static void main(String[] args) throws IOException {
        BufferedReader inputStream = null;
        PrintStream printStream = new PrintStream(System.out);
        try{
            inputStream = new BufferedReader(new FileReader("input.txt"));
            String line;
            while ((line = inputStream.readLine()) != null){
                printStream.println(line);
            }
        }finally {
            if(inputStream != null) inputStream.close();
            printStream.flush();
        }
    }
}
