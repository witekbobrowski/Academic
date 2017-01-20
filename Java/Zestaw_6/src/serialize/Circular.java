package serialize;

import java.io.*;
import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;

public class Circular<E extends Serializable> implements Serializable, BlockingQueue<E> {

    public E[] buffer;
    public int head;
    public int tail;

    Circular(Class<E> clazz, int size){

        @SuppressWarnings("unchecked")
        final E[] buffer = (E[]) Array.newInstance(clazz, size);
        this.buffer = buffer;
        this.head = 0;
        this.tail = 0;
    }

    //Iterator
    public class CircularIterator<E extends Serializable> implements Iterator<E>{

        int position;

        public CircularIterator(){
            position = 0;
        }

        @Override
        public boolean hasNext(){
            this.position %= buffer.length;
            return buffer[this.position] != null;
        }

        @SuppressWarnings("Unchecked")
        @Override
        public E next(){
            this.position %= buffer.length;
            return (E) buffer[this.position++];
        }

        @Override
        public void remove() {
            throw new UnsupportedOperationException();
        }
    }

    private boolean isBehind(){
        return ((this.head == (this.tail)) && (this.buffer[this.tail] != null)) || ((this.head == (this.buffer.length - 1)) && this.tail == 0);
    }

    @Override
    public synchronized boolean add(E e) {
        if(offer(e)){
            head = head % buffer.length;
            return true;
        } else {
            throw new IllegalStateException("head reached the tail");
        }
    }

    @Override
    public synchronized boolean offer(E e) {
        if (e == null) throw new NullPointerException();
        else if (!isBehind()){
            buffer[head++] = e;
            head = head % buffer.length;
            return true;
        } else
            return false;
    }

    @Override
    public synchronized E remove() {
        E temp = poll();
        if(temp == null)
            throw new NoSuchElementException();
        return null;
    }

    @Override
    public synchronized E poll() {
        if(this.buffer[this.head - 1] != null) {
            E temp = this.buffer[this.head - 1];
            this.buffer[this.head -1] = null;
            head--;
            return temp;
        } else
            return null;
    }

    @Override
    public E element() {
        return null;
    }

    @Override
    public E peek() {
        return null;
    }

    @Override
    public synchronized void put(E e) throws InterruptedException {
        while(isBehind()){
            this.wait();
        }
        offer(e);
    }

    @Override
    public boolean offer(E e, long timeout, TimeUnit unit) throws InterruptedException {
        return false;
    }

    @Override
    public synchronized E take() throws InterruptedException {
        E temp = poll();
        while(temp == null){
            this.wait();
            temp = poll();
        }
        this.notify();
        return temp;
    }

    @Override
    public E poll(long timeout, TimeUnit unit) throws InterruptedException {
        return null;
    }

    @Override
    public int remainingCapacity() {
        return 0;
    }

    @Override
    public boolean remove(Object o) {
        for(int i = 0; i < this.buffer.length; i++){
            if(buffer[i] == o) {
                buffer[i] = null;
                return true;
            }
        }
        throw new NoSuchElementException("element not found");
    }

    @Override
    public boolean containsAll(Collection<?> c) {
        return false;
    }

    @Override
    public boolean addAll(Collection<? extends E> c) {
        return false;
    }

    @Override
    public boolean removeAll(Collection<?> c) {
        return false;
    }

    @Override
    public boolean retainAll(Collection<?> c) {
        return false;
    }

    @Override
    public void clear() {

    }

    @Override
    public int size() {
        return 0;
    }

    @Override
    public boolean isEmpty() {
        return false;
    }

    @Override
    public boolean contains(Object o) {
        return false;
    }

    @Override
    public Iterator<E> iterator() {
        return new CircularIterator<>();
    }

    @Override
    public Object[] toArray() {
        return new Object[0];
    }

    @Override
    @SuppressWarnings("Unchecked")
    public <T> T[] toArray(T[] a) {
        Object[] temp = Arrays.copyOf(this.buffer, this.buffer.length);
        return (T[]) temp;
    }

    @Override
    public int drainTo(Collection<? super E> c) {
        return 0;
    }

    @Override
    public int drainTo(Collection<? super E> c, int maxElements) {
        return 0;
    }
}


