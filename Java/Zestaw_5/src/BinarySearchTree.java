import java.util.Collection;
import java.util.Iterator;
import java.util.Stack;

//I GIVE UP

public class BinarySearchTree <E extends Comparable<? super E>> implements Collection<E> {

    public Node root;
    public int size = 0;

    public BinarySearchTree(){
        this.root = null;
    }

    public BinarySearchTree(Node<E> e){
        this.root = e;

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

        public E getValue(){
            return value;
        }

    }

    private class BinaryIterator<E extends Comparable<? super E>> implements Iterator<E>{

        Stack<Node<E>> stack;

        public BinaryIterator(Node<E> root) {
            stack = new Stack<Node<E>>();
            while (root != null) {
                stack.push(root);
                root = root.left;
            }
        }

        public boolean hasNext() {
            return !stack.isEmpty();
        }

        public E next() {
            Node<E> node = stack.pop();
            E value = node.getValue();
            if (node.getRight() != null) {
                node = node.getRight();
                while (node != null) {
                    stack.push(node);
                    node = node.getLeft();
                }
            }
            return value;
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
        return new BinaryIterator<E>(root);
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
        Node current = root;
        if (current == null){
            current = new Node(e);
        }else if (current.getValue().compareTo(e) > 0){
            current.left = new Node(e);
            return true;
        }else if (current.getValue().compareTo(e) < 0) {
            current.right = new Node(e);
            return true;
        }
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
