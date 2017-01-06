#Zestaw 2
![alt tag](/Java/Zestaw_2/Adder.png)
Termin: 26.10.2016

Pliki źródłowe umieścić w katalogu start, a klasy w pakiecie o tej samej nazwie komendą package start.
Z poziomu katalogu zawierającego folder start:

Kompilacja: javac start/Test.java lub javac8 start/Test.java
Wywołanie: java start.Test lub java8 start.Test

Dodać komentarze i użyć narzędzia javadoc do wygenerowania dokumentacji.

###Zadanie 1. Sumator

Klasa ma dziedziczyć po klasie javax.swing.JFrame i implementować interfejs java.awt.event.ActionListener. Program ma wyświetlać okienko z następującymi komponentami z pakietu javax.swing: JTextField (× 2), JButton i JLabel. Po naciśnięciu przycisku aplikacja ma wypisać w etykiecie sumę liczb wpisanych w pola tekstowe. Aby ułożyć komponenty pionowo użyć javax.swing.JPanel i java.awt.GridLayout. Obsłużyć wyjątek java.lang.NumberFormatException.

Zamiast Swing można użyć technologii JavaFX.

###Zadanie 2. CopyFile

Zmodyfikować program Print z poprzedniego zestawu. Program ma kopiować zawartość jednego pliku do drugiego (pliki binarne), nazwy plików są podane jako argumenty z linii komend. Zaimportować pakiet java.io. Użyć klas FileInputStream i FileOutputStream oraz metod read i write. Jako bufor pośredni użyć tablicy bajtów.
Ze względu na ograniczony rozmiar tablicy operacje należy umieścić w odpowiedniej pętli. Obsłużyć odpowiednie wyjątki.

###Zadanie 3 PrintFile

Program ma wyświetlać zawartość pliku tekstowego linijka po linijce i je numerować. Nazwa pliku jest podana jako argument z linii komend. Zaimportować pakiet java.io. Użyć klas FileReader i BufferedReader. Obsłużyć odpowiednie wyjątki.

###Zadanie 4. DivideByZeroException i Divide

Klasa DivideByZeroException ma dziedziczyć po java.lang.Exception.
Jest to wyjątek wyrzucany przez klasę Divide w przypadku próby wykonania dzielenia przez zero. Napisać konstruktor DivideByZeroException(String a, String b), gdzie a i b to argumenty dzielenia. Konstruktor ma zapisać do zmiennej typu String komunikat o błędzie. Przeciążyć metodę getMessage, ma ona zwracać napis z komunikatem. Dodać adnotację @Override przed deklaracją metody, która informuje (nie jest niezbędna) kompilator, że chcemy ją przeciążyć.

Zaimplementować klasę Divide i metodę statyczną public static double div(double a, double b), która zwraca wynik dzielenia a/b lub wyrzuca wyjątek (gdy b = 0). Należy odpowiednio użyć słów kluczowych throws i throw. Zaimplementować funkcję main , która wypisuje wynik dzielenia. Argumenty są podane w linii komend. W przypadku wyrzucenia wyjątku nie przechwytywać go tylko wyrzucić dalej.

###Zadanie 5. Complex

Proszę zaimplementować klasę Complex obsługującą liczby zespolone i klasę ComplexTest, która testuje funkcje klasy Complex.   
```
public class Complex
{
private double r, i;

    Complex();
    Complex(double);
    Complex(double, double);
    Complex(Complex);
    Complex(String);

    static Complex add(Complex, Complex); 
    /* Zwraca sumę dwóch liczb zespolonych */
    static Complex sub(Complex, Complex); 
    /* Zwraca różnice dwóch liczb zespolonych */
    static Complex mul(Complex, Complex); 
    /* Zwraca iloczyn dwóch liczb zespolonych */
    static Complex div(Complex, Complex); 
    /* Zwraca iloraz dwóch liczb zespolonych */
    static double abs(Complex);       
    /* Zwraca moduł liczby zespolonej */    
    static double phase(Complex);         
    /* Zwraca faze liczby zespolonej */ 
    static double sqrAbs(Complex);
    /* Zwraca kwadrat modułu liczby zespolonej */   
    static double re(Complex);
    /* Zwraca część rzeczywistą liczby zespolonej */    
    static double im(Complex);
    /* Zwraca część urojoną liczby zespolonej */    

    /* Poniższe metody modyfikuja aktualny obiekt i zwracają 'this' */

    Complex add(Complex);   // Dodaje liczbę zespoloną
    Complex sub(Complex);   // Odejmuje liczbę zespoloną
    Complex mul(Complex);   // Mnoży przez liczbę zespoloną
    Complex div(Complex);   // Dzieli przez liczbę zespoloną
    double abs();
    double sqrAbs();
    double re();
    double im();
    
    String toString();
    /* Zwraca String z zapisaną 
        liczbą zespoloną formacie "-1.23+4.56i" */

    static Complex valueOf(String);
    /* Zwraca liczbę zespolona o wartości podanej 
        w argumencie w formacie "-1.23+4.56i" */

    void setRe(double);
    /* Przypisuje podaną wartość części rzeczywistej */

    void setIm(double);
    /* Przypisuje podaną wartość części urojonej */

    void setVal(Complex);
    void setVal(double, double);
    /* Przypisuje podaną wartość */
}   
```
Powyższe metody i konstruktory proszę zadeklarować jako publiczne.
Przydatne klasy: java.lang.Math.

credit:   
Andrzej Görlich   
andrzej.goerlich@uj.edu.pl   
http://th.if.uj.edu.pl/~atg/Java
