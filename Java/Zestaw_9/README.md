#Zestaw 9
Język Java
Termin: 18.01.2017

Klasy umieścić w pakiecie reflection.
Dodać komentarze i użyć narzędzia javadoc do wygenerowania dokumentacji.
Szczegóły dotyczące programowania refleksyjnego w Javie można znaleźć w wykładzie.

###Zadanie 1. Signature - obowiązkowe dla osób, które 17.01.2017 mają 1 lub więcej nieoddanych zestawów

Napisać program, który czyta nazwę klasy z linii komend i wypisuje interfejs klasy w składni Javy (interfejs lub klasa, modyfikatory, konstruktory, metody, pola; pominąć ciała metod).

Wskazówka: 
```
Klasę, której nazwę znamy można załadować używając  java.lang.Class.forName(). Klasa java.lang.Class zawiera szeroki wachlarz narzędzi, które pozwalają na sprawdzenie interfejsu dowolnej klasy.
```
Program należy zastosować na kilku klasach i interfejsach a także na samym sobie.

###Zadanie 2. Creator - obowiązkowe dla osób, które 17.01.2017 mają 2 lub więcej nieoddanych zestawów

Napisać program, który wczyta nazwę klasy oraz listę argumentów i stworzy obiekt tej klasy, przekazując wczytane argumenty do konstruktora. Wczytać nazwę metody i ją wywołać na stworzonym obiekcie.

Wskazówka: 
```
Traktować argumenty jako obiekty klasy String. Klasa  java.lang.Class potrafi zwrócić tablicę konstruktorów. Wybrać konstruktor z odpowiednią liczbą argumentów i znaleźć ich typy. Aby stworzyć obiekty danego typu wywołać odpowiedni kontruktor, który przyjmuje String jako jedyny argument. Dynamicznie wywołać konstruktor używając  java.lang.reflect.Constructor.newInstance().
```

credit:   
Andrzej Görlich   
andrzej.goerlich@uj.edu.pl   
http://th.if.uj.edu.pl/~atg/Java

