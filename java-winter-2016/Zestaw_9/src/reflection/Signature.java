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
            Constructor constructors[] = classToDump.getDeclaredConstructors();
            Class classes[] = classToDump.getDeclaredClasses();
            Method methods[] = classToDump.getDeclaredMethods();
            output += "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n┃ " + className + " :\n";
            if(fields.length > 0) {
                output += "┃┏━━━━━━━━━━━━━━━━━━━━━━━━━┓\n";
                output += "┃┃ Fields :                ┃\n" +
                          "┃┗━━━━━━━━━━━━━━━━━━━━━━━━━┛\n";
                for(int i = 0 ; i < fields.length ; i++){
                    if (fields.length == 1)
                        output += "┃ ┈ " + fields[i].toString() + "\n";
                    else if (i == 0)
                        output += "┃┎┈ " + fields[i].toString() + "\n";
                    else if (i == fields.length - 1)
                        output += "┃┖┈ " + fields[i].toString() + "\n";
                    else
                        output += "┃┠┈ " + fields[i].toString() + "\n";
                }
            }
            if(constructors.length > 0) {
                output += "┃┏━━━━━━━━━━━━━━━━━━━━━━━━━┓\n";
                output += "┃┃ Constructors :          ┃\n" +
                          "┃┗━━━━━━━━━━━━━━━━━━━━━━━━━┛\n";
                for (int i = 0; i < constructors.length; i++) {
                    if (constructors.length == 1)
                        output += "┃ ┈ " + constructors[i].toString() + "\n";
                    else if (i == 0)
                        output += "┃┎┈ " + constructors[i].toString() + "\n";
                    else if (i == constructors.length - 1)
                        output += "┃┖┈ " + constructors[i].toString() + "\n";
                    else
                        output += "┃┠┈ " + constructors[i].toString() + "\n";
                }
            }
            if(classes.length > 0) {
                output += "┃┏━━━━━━━━━━━━━━━━━━━━━━━━━┓\n";
                output += "┃┃ Classes or Interfaces : ┃\n" +
                          "┃┗━━━━━━━━━━━━━━━━━━━━━━━━━┛\n";
                for (int i = 0; i < classes.length; i++) {
                    if (classes.length == 1)
                        output += "┃ ┈ " + classes[i].toString() + "\n";
                    else if (i == 0)
                        output += "┃┎┈ " + classes[i].toString() + "\n";
                    else if (i == classes.length - 1)
                        output += "┃┖┈ " + classes[i].toString() + "\n";
                    else
                        output += "┃┠┈ " + classes[i].toString() + "\n";
                }
            }
            if(methods.length > 0) {
                output += "┃┏━━━━━━━━━━━━━━━━━━━━━━━━━┓\n";
                output += "┃┃ Methods :               ┃\n" +
                          "┃┗━━━━━━━━━━━━━━━━━━━━━━━━━┛\n";
                for (int i = 0; i < methods.length; i++) {
                    if (methods.length == 1)
                        output += "┃ ┈ " + methods[i].toString() + "\n";
                    else if (i == 0)
                        output += "┃┎┈ " + methods[i].toString() + "\n";
                    else if (i == methods.length - 1)
                        output += "┃┖┈ " + methods[i].toString() + "\n";
                    else
                        output += "┃┠┈ " + methods[i].toString() + "\n";
                }
            }
            output += "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
        }catch (ClassNotFoundException e){
            System.err.println(e);
        }
        System.out.println(output);
    }

    static boolean dumpConstructors(String className){

        String output = "";

        try{
            Class classToDump = Class.forName(className);
            Constructor constructors[] = classToDump.getDeclaredConstructors();
            output += "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n┃ " + className + " :\n";

            if(constructors.length > 0) {
                output += "┃┏━━━━━━━━━━━━━━━━━━━━━━━━━┓\n";
                output += "┃┃ Constructors :          ┃\n" +
                          "┃┗━━━━━━━━━━━━━━━━━━━━━━━━━┛\n";
                for (int i = 0; i < constructors.length; i++) {
                    if (constructors.length == 1)
                        output += "┃ ┈ " + constructors[i].toString() + "\n";
                    else if (i == 0)
                        output += "┃┎┈ " + constructors[i].toString() + "\n";
                    else if (i == constructors.length - 1)
                        output += "┃┖┈ " + constructors[i].toString() + "\n";
                    else
                        output += "┃┠┈ " + constructors[i].toString() + "\n";
                }
                output += "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
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

    static boolean dumpMethods(String className){

        String output = "";

        try{
            Class classToDump = Class.forName(className);
            Method methods[] = classToDump.getDeclaredMethods();
            output += "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n┃ " + className + " :\n";

            if(methods.length > 0) {
                output += "┃┏━━━━━━━━━━━━━━━━━━━━━━━━━┓\n";
                output += "┃┃ Methods :               ┃\n" +
                          "┃┗━━━━━━━━━━━━━━━━━━━━━━━━━┛\n";
                for (int i = 0; i < methods.length; i++) {
                    if (methods.length == 1)
                        output += "┃ ┈ " + methods[i].toString() + "\n";
                    else if (i == 0)
                        output += "┃┎┈ " + methods[i].toString() + "\n";
                    else if (i == methods.length - 1)
                        output += "┃┖┈ " + methods[i].toString() + "\n";
                    else
                        output += "┃┠┈ " + methods[i].toString() + "\n";
                }
                output += "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
            }else{
                output = "This class has no methods...";
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