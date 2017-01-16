#Zestaw 5

Klasy umieścić w pakiecie generics.
Proszę napisać dwa zadania.
Dodać komentarze i użyć narzędzia javadoc do wygenerowania dokumentacji.
Szczegóły dotyczące typów generycznych można znaleźć w wykładzie.

###Zadanie 1. Kolor, Mieszadlo

Zapoznać się ze stronami enums i RGB model.
Napisać typ wyliczeniowy Kolor. Powinien on zawierać przynajmniej takie przedmioty jak
```
BLACK, WHITE, GREY, RED, GREEN, BLUE, YELLOW, CYAN, MAGENTA
```
Każdy przedmiot jest charakteryzowany przez trzy liczby typu double (od 0 do 1) r, g, b (odpowiednie składowe kolorów podstawowych RGB). Proszę napisać odpowiedni konstruktor. Napisać metodę (wykonywaną na przedmiocie)
```
boolean porownaj(double r, double g, double b);
```
która zwraca true gdy argumenty są dokładnie takie jak parametry koloru. Napisać metodę statyczną
```
public static Kolor nazwij(double r, double g, double b);
```
która zwraca przedmiot, który dokładnie odpowiada składowym r, g, b. Gdy taki przedmiot nie istnieje zwraca null. Użyć metody statycznej values() i konstrukcji
```
for(Kolor a : values()){ ...}
```
Napisać typ wyliczeniowy Mieszadlo. Powinien on zawierać rożne rodzaje mieszania kolorów np.
```
ADD (addtywne)
MUL (multiplikatywne)
AVER (średnia)
```
itd. Zadeklarować abstrakcyjną metodę
```
abstract Kolor mieszaj(Kolor a, Kolor b);
```
Każda operacja (przedmiot) ma ją zaimplementować. Metoda ta zwraca wynik mieszania kolorów a i b lub  null. Dodać metodę (statyczną) main, która wypisuje wszystkie możliwości mieszania. Pominąć wyniki dające null. Przykładowy rezultat dla kolorów RED, GREEN, YELLOW, BLACK i operacji  ADD, MUL.

###Zadanie 2. BinarySearchTree

Napisać klasę BinarySearchTree<E extends Comparable<? super E>> implementującą  Collection<E> oraz klasę Node<E extends Comparable<? super E>>. Więcej informacji o typach generycznych można znaleźć w Wykładzie 4.. Klasy te mają obsługiwać dynamiczną strukturę danych - binarne drzewo poszukiwań [Cormen, 2013]. W szczególności zdefiniować metody add (wstawianie elementu), toArray i iterator. Pozostałe metody z pustą definicją z interfejsu  Collection powinny wyrzucać wyjątek UnsupportedOperationException. Elementy struktury danych mają być dodawane dynamicznie w taki sposób aby przechodzenie drzewa zwracało je w posortowanej kolejności. Ostatnia metoda ma zwracać obiekt klasy  BinaryIterator<E extends Comparable<? super E>>, która implementuje interfejs  Iterator<E>. Zaimplementować metody iteracyjne (na potrzeby iterator) i rekurencyjne (na potrzeby toArray) do przechodzenia drzewa (in-order).

Napisać interfejs Pair<K, V>, który posiada metody K getKey() i V getValue(). Napisać klasę  OrderedPair<K extends Comparable<? super K>, V> implementującą interfejsy  Comparable <OrderedPair<K, V>> i Pair<K, V>. Zdefiniować konstruktor oraz metody  compareTo, toString, getKey i getValue.

Stworzyć obiekt list klasy BinarySearchTree i kilka obiektów klasy  OrderedPair<String, String>. Sprawdzić działanie iteratora wypisując posortowane elementy przy użyciu pętli for(Object e : list).

###Zadanie 3. MergeSort

Zaimplementować algorytm sortowania przez scalanie z wykorzystaniem wątków. Można to zrobić na wiele sposobów, ale zamiast implementować klasę dziedziczącą po Thread z metodą public void run(), warto użyć mechanizmu Future i Callable (przykład użycia).
Schemat:
```
import java.util.concurrent.*;

public class Compute implements Callable<Integer> {
    public Integer call() throws Exception { ... obliczenia ... }
    public static void someFunction() throws Exception {
        ExecutorService pool = Executors.newFixedThreadPool(...);
        Future<Integer> f   = pool.submit(new Compute(...));
        // Wywołać odpowiednią liczbę wątków
        ...
        Integer r   = f.get();  
        // Odebrać wyniki
        ...
        pool.shutdownNow();
    }
}
```
Obiekt klasy implementującej interfejs Callable<V> jest wątkiem, który zwraca wynik (np. obliczeń) typu V. Alternatywnie można stworzyć obiekt klasy anonimowej (patrz Zestaw 3.) implementującej interfejs  Callable.

Dodać funkcją statyczną public static void sort(int[]) i ustawić maksymalną liczbę wątków.

Zmierzyć czas sortowania (np. 107 elementów) wersji jednowątkowej i wielowątkowej. Można wykorzystać mechanizmy Instant (od Java 8), System.currentTimeMillis() lub System.nanoTime().

Następnie rozszerzyć klasę o typy generyczne  MergeSortGen<E extends Comparable<? super E>>.

credit:   
Andrzej Görlich   
andrzej.goerlich@uj.edu.pl   
http://th.if.uj.edu.pl/~atg/Java
