package start;

public class DivideByZeroException extends Exception {

    private String a;
    private String b;

    public DivideByZeroException(){
        super();
    }

    public DivideByZeroException(String message){
        super(message);
    }

    public DivideByZeroException(String a, String b){
        super();
        this.a=a;
        this.b=b;
    }

    @Override
    public String getMessage() {
        return "You Can't divide by zero!";
    }


}
