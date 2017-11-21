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
            System.out.println("Enter argument:");
            String inputArgument = scanner.next();
            Signature.clearTerminal();
            Signature.dumpMethods(inputClass);
            System.out.println("Now choose a method that takes 'null' arguments that you want to call on the object");
            String inputMethod = scanner.next();
            Signature.clearTerminal();
            newInstance(inputClass, inputArgumentType, inputArgument, inputMethod);
        }
    }

    public static void newInstance(String classString, String typeString, String valueString, String methodString){
        try {
            Class clazz = Class.forName(classString);
            Class type = Class.forName(typeString);
            Constructor clazzConstructor = clazz.getDeclaredConstructor(type);
            Constructor typeConstructor = type.getDeclaredConstructor(valueString.getClass());
            Method clazzMethod = clazz.getMethod(methodString, null);
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
