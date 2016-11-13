#Zestaw 1
Język Java
Termin: 19.10.2016

Pliki źródłowe umieścić w katalogu hello, ale dodawać klas do pakietu (nie używać słowa kluczowego package).

###Zadanie 1.

Zapoznać się z dokumentacją interfejsu programowania aplikacji w Javie (Application Programming Interface, JDK 8 Documentation, 90MB).

Zapoznać się z pakietami oraz możliwościami i właściwościami klas:

java.lang: System, String, Integer, Object, Class, Exception, Math
java.io: PrintStream, File, FileInputStream, FileNotFoundException
java.applet
javax.swing: JApplet, JFrame, ImageIcon
javafx: application.Application, scane.Scene, stage.Stage
###Zadanie 2.

Rozszerzyć odpowiednio klasy java.lang.Object (domyślnie), javax.swing.JFrame, javafx.application.Application i javax.swing.JApplet.

Napisać klasę publiczną HelloStatic, która zawiera statyczne wyrażenie inicjujące oraz konstruktor. Zaimplementować funkcję publiczą statyczną public static void main(String[] args), która tworzy obiekt tej klasy. Wszystkie metody i wyrażenie statyczne powinny wyświetlać odpowiedni komunikat w konsoli. Klasę zapisać w pliku HelloStatic.java.

Napisać program HelloSwing.java, który wyświetla okno wraz z komunikatem. Użyć pakietu java.swing (patrz zadanie 2.).

Napisać program HelloFX.java, który wyświetla okno wraz z komunikatem. Użyć pakietu javafx. Na komputerach w pracowni należy użyć kompilatora javac8 i JVM java8.

Napisać aplet HelloApplet.java, który wyświetla komunikat w oknie przeglądarki internetowej (napisać też odpowiedni plik html).

Programy można skompilować przy użyciu komendy javac Hello.java, kompilator jest zainstalowany na komputerach studenckiej pracowni pod linuxem. Sprawdzić czy programy działają, np. komendą java Hello, lub appletviewer HelloApplet.html.

Przykładowe programy zostały wprowadzone na wykładzie.

###Zadanie 3. Print

Napisać i skompilować program wypisujący zawartość dowolnego pliku na ekran konsoli.

Wskazówka: Proszę wykorzystać klasy wspomniane powyżej(wystarczą pierwsze trzy). Niektóre metody zwracają wyjątki(exceptions), taki fragment kodu należy objąć komendą try { ... }, a następnie złapać wyjątki przy pomocy komendy catch(Exception e) { ... }. Pomocny może się okazać poniższy schemat kodu:

try
{
    /* Tu nalezy odczytac i wypisac
       zawartosc jakiegos pliku */
    ...
}
catch(FileNotFoundException e)
{
    System.out.println("Plik nie zostal znaleziony");
}
catch(IOException e)
{
    System.out.println("Blad wejscia/wyjscia");
}
Wskazówka: Tablice bajtów deklarujemy w następujący sposób:

byte[] data;
a definiujemy (automatycznie alokuje pamięc i inicjalizuje do zer, porównaj z C/C++) tak:

data = new byte[len];
W Javie tablice są obiektami. Ich długość można odczytać z pola length, np. data.length.

Andrzej Görlich
andrzej.goerlich@uj.edu.pl
http://th.if.uj.edu.pl/~atg/Java

