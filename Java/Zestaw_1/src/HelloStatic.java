public class HelloStatic{

    static {
        System.out.println("statyczne wyrażenie inicjujące :)\n");
    }

    private HelloStatic(){
        System.out.println("Konstruktor :)\n");
    }

    public static void main(String[] args) {
        HelloStatic hello = new HelloStatic();
    }
}