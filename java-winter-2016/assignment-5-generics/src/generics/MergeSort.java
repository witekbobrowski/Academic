package generics;

import java.util.concurrent.RecursiveAction;

public class MergeSort<T extends Comparable<? super T>> extends RecursiveAction{

    private T[] array;
    private T[] temp;
    private int start, end;

    public MergeSort(T[] array, T[] temp , int start, int end){
        this.array = array;
        this.temp = temp;
        this.start = start;
        this.end = end;
    }

    @Override
    protected void compute() {
        if (start == end) return;
        int mid = start + (end-start)/2;
        invokeAll(new MergeSort<T>(array, temp, start, mid), new MergeSort<T>(array, temp, mid+1, end));
        merge(this.array, this.start, mid, this.end);
    }

    private void merge(T[] array, int start , int mid, int end){
        System.arraycopy(array, start, temp, start, end + 1 - start);
        int i = start, j = mid+1;
        for (int k = start ; k <= end; k++){
            if (i > mid)
                array[k] = temp[j++];
            else if (j > end)
                array[k] = temp[i++];
            else if (temp[i].compareTo(temp[j]) < 0)
                array[k] = temp[i++];
            else
                array[k] = temp[j++];
        }
    }

}