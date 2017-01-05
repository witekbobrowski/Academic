package reflection;

import java.lang.reflect.*;
import java.util.Scanner;

public class Signature {

    public static void main(String args[]){
        final String ANSI_CLS = "\u001b[2J";
        final String ANSI_HOME = "\u001b[H";
        System.out.print(ANSI_CLS + ANSI_HOME);
        System.out.flush();
        System.out.println("Enter Class name and path:");
        Scanner scanner = new Scanner(System.in);
        String input = scanner.next();
        System.out.print(ANSI_CLS + ANSI_HOME);
        System.out.flush();
        dumpClass(input);
    }

    private static void dumpClass(String className){

        String output = "";

        try{
            Class classToDump = Class.forName(className);
            Field fields[] = classToDump.getDeclaredFields();
            Constructor constructors[] =classToDump.getDeclaredConstructors();
            Class classes[] = classToDump.getDeclaredClasses();
            Method methods[] = classToDump.getDeclaredMethods();
            output += "---------------------------- \n" + className + " :\n";

            if(fields.length > 1) {
                output += "-------------- \nFields :\n";
                for(int i = 0 ; i < fields.length ; i++){
                    output += fields[i].toString() + "\n";
                }
            }
            if(constructors.length > 1) {
                output += "-------------- \nConstructors :\n";
                for (int i = 0; i < constructors.length; i++) {
                    output += constructors[i].toString() + "\n";
                }
            }
            if(classes.length > 1) {
                output += "-------------- \nClasses or interfaces :\n";
                for (int i = 0; i < classes.length; i++) {
                    output += classes[i].toString() + "\n";
                }
            }
            if(methods.length > 1) {
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
}