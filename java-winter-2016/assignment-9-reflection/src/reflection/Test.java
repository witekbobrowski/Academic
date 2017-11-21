package reflection;


public class Test {

    String property = "";

    public Test() {
        property = "empty";
        System.out.println("skrr skrr");
    }

    public Test(String a) {
        property = "You have called the constructor that takes 'String'(" + a + ") as an Argument and created an object";
    }

    public Test(Integer a) {
        property = "You have called the constructor that takes 'Integer'(" + a + ") as an Argument and created an object";
    }

    public Test(Long a) {
        property = "You have called the constructor that takes 'Long'(" + a + ") as an Argument and created an object";
    }

    public Test(Double a) {
        property = "You have called the constructor that takes 'Double'(" + a + ") as an Argument and created an object";
    }

    public Test(Float a) {
        property = "You have called the constructor that takes 'Float'(" + a + ") as an Argument and created an object";
    }

    public Test(Boolean a) {
        property = "You have called the constructor that takes 'Boolean'(" + a + ") as an Argument and created an object";
    }

    public void print(){
        System.out.println(this.property + " then succesfully called the method on it.");
    }

}
