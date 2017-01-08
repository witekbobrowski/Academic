package generics;

import java.lang.reflect.Array;
import java.util.Random;
import java.util.concurrent.ForkJoinPool;

public class Tester {

    public static void main(String[] args){
        clearTerminal();
        System.out.println("This is MergeSort tester.");
        int arraySize = 10000000;
        System.out.println("Generating array with " + arraySize + " elements...");
        int[] temp = new Random().ints(arraySize, 1, arraySize).toArray();
        Integer[] array = new Integer[arraySize];
        for(int i=0; i<arraySize; ++i)
            array[i] = temp[i];
        System.out.println("Sorting array...");
        long start = System.currentTimeMillis();
        mergeSort(array);
        long finish = System.currentTimeMillis();
        clearTerminal();
        System.out.println("Array sorted in " + (finish-start) + " ms");
    }

    public static <T extends Comparable<? super T>> void mergeSort(T[] input) {
        T[] temp = (T[])Array.newInstance(input[0].getClass() , input.length);
        ForkJoinPool forkJoinPool= new ForkJoinPool();
        forkJoinPool.invoke(new MergeSort<T>(input, temp, 0, input.length-1));
    }

    protected static void clearTerminal(){
        final String ANSI_CLS = "\u001b[2J";
        final String ANSI_HOME = "\u001b[H";
        System.out.print(ANSI_CLS + ANSI_HOME);
        System.out.flush();
    }
}