package reflection;

import java.lang.invoke.MethodHandle;
import java.lang.reflect.*;
import java.util.Scanner;

public class Creator {

    public static void main(String args[]){
        Signature.clearTerminal();
        System.out.println("Enter Class of which you want to create object:");
        Scanner scanner = new Scanner(System.in);
        String inputClass = scanner.next();
        Signature.clearTerminal();
        if (Signature.dumpConstructors(inputClass)) {
            System.out.println("Enter argument Type:");
            String inputArgumentType = scanner.next();
            System.out.println("\nEnter argument:");
            String inputArgument = scanner.next();
            newInstance(inputClass, inputArgumentType, inputArgument);
        }
    }

    public static void newInstance(String classString, String typeString, String valueString){
        try {
            Class clazz = Class.forName(classString);
            Class type = Class.forName(typeString);
            Constructor clazzConstructor = clazz.getDeclaredConstructor(type);
            Constructor typeConstructor = type.getDeclaredConstructor(valueString.getClass());
            Method clazzMethod = clazz.getMethod("print", null);
            Object object = clazzConstructor.newInstance(typeConstructor.newInstance(valueString));
            clazzMethod.setAccessible(true);
            clazzMethod.invoke(object);
        } catch (ClassNotFoundException e){
            System.out.println(e);
        } catch (NoSuchMethodException e){
            System.out.println(e);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }
}
