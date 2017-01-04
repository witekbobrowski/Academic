import java.util.Collection;
import java.util.Iterator;
import java.util.NoSuchElementException;

public class BinarySearchTree <E extends Comparable<? super E>> implements Collection<E> {

    public Node root;

    public BinarySearchTree(){
        this.root = null;
    }

    public class Node<E extends Comparable<? super E>>{

        public E value;
        public Node<E> left;
        public Node<E> right;

        public Node(E value){
            this.value = value;
            this.left = null;
            this.right = null;
        }

        public Node<E> getLeft(){
            return left;
        }

        public Node<E> getRight(){
            return right;
        }

    }

    private class BinaryIterator<E extends Comparable<? super E>> implements Iterator<E>{

        public Node<E> node;

        public BinaryIterator(Node<E> node){
           this.node = node;
        }

        public boolean hasLeft(){
            if(node.getLeft() != null) {
                return true;
            }else return false;
        }

        public boolean hasRight(){
            if(node.getRight() != null) {
                return true;
            }else return false;
        }

        @Override
        public boolean hasNext() {
            if (hasRight() || hasLeft()){
                return true;
            }
            return false;
        }

        @Override
        public E next() throws NoSuchElementException{
            try{
                Node<E> temp = root;
            }catch(NoSuchElementException e){
                return temp;
            }
        }
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
        return null;
    }

    @Override
    public Object[] toArray() {
        return new Object[0];
    }

    @Override
    public <T> T[] toArray(T[] a) {
        return null;
    }

    @Override
    public boolean add(E e) {
        Node newNode = new Node(e);

        return false;
    }

    @Override
    public boolean remove(Object o) {
        return false;
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
}
