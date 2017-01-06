package reflection;

import java.lang.reflect.*;
import java.util.Scanner;

public class Signature {

    public static void main(String args[]){
        clearTerminal();
        System.out.println("Enter class/interface you want to reflect:");
        Scanner scanner = new Scanner(System.in);
        String input = scanner.next();
        clearTerminal();
        dumpClass(input);
    }

    protected static void dumpClass(String className){

        String output = "";

        try{
            Class classToDump = Class.forName(className);
            Field fields[] = classToDump.getDeclaredFields();
            Constructor constructors[] =classToDump.getDeclaredConstructors();
            Class classes[] = classToDump.getDeclaredClasses();
            Method methods[] = classToDump.getDeclaredMethods();
            output += "---------------------------- \n" + className + " :\n";
            if(fields.length > 0) {
                output += "-------------- \nFields :\n";
                for(int i = 0 ; i < fields.length ; i++){
                    output += fields[i].toString() + "\n";
                }
            }
            if(constructors.length > 0) {
                output += "-------------- \nConstructors :\n";
                for (int i = 0; i < constructors.length; i++) {
                    output += constructors[i].toString() + "\n";
                }
            }
            if(classes.length > 0) {
                output += "-------------- \nClasses or interfaces :\n";
                for (int i = 0; i < classes.length; i++) {
                    output += classes[i].toString() + "\n";
                }
            }
            if(methods.length > 0) {
                output += "-------------- \nMethods :\n";
                for (int i = 0; i < methods.length; i++) {
                    output += methods[i].toString() + "\n";
                }
            }
        }catch (ClassNotFoundException e){
            System.err.println(e);
        }
        System.out.println(output);
    }

    static boolean dumpConstructors(String className){

        String output = "";

        try{
            Class classToDump = Class.forName(className);
            Constructor constructors[] =classToDump.getDeclaredConstructors();
            output += "---------------------------- \n" + className + " constructors :\n";

            if(constructors.length > 1) {
                output += "----------------------------\n";
                for (int i = 0; i < constructors.length; i++) {
                    output += constructors[i].toString() + "\n";
                }
            }else{
                output = "This class has no constructors...";
                System.out.println(output);
                return false;
            }
        }catch (ClassNotFoundException e){
            System.err.println(e);
            output = "This class does not exist...";
            System.out.println(output);
            return false;
        }
        System.out.println(output);
        return true;
    }

    protected static void clearTerminal(){
        final String ANSI_CLS = "\u001b[2J";
        final String ANSI_HOME = "\u001b[H";
        System.out.print(ANSI_CLS + ANSI_HOME);
        System.out.flush();
    }
}