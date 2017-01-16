#Zestaw 4

Klasy umieścić w pakiecie watki.
Dodać komentarze i użyć narzędzia javadoc do wygenerowania dokumentacji.
Szczegóły dotyczące wątków można znaleźć w wykładzie.

###Zadanie 1. Playground, Ball, Box

Napisać klasę Playground, która dziedziczy po javax.swing.JFrame i wyświetla okno  javax.swing.JPanel, a w nim kulki (pełne okregi), które poruszają się z jednakową prędkością ale każda w losowym kierunku (początkowo).

Kulki (klasa Ball) mają się odbijać od ścianek (idealnie sprężyście). Dodać do Playground przycisk, który tworzy nowe obiekty klasy Ball.

Klasa Ball ma dziedziczyć po java.lang.Thread, czyli każda kulka ma być osobnym wątkiem. Proszę zapoznać się z klasą Thread i metodami run(), start(), sleep(), interrupt(), suspend() i  resume() oraz interfejsem Runnable. Kliknięcie lewym przyciskiem myszki na kulkę ma zatrzymywać/uruchomić jej wątek. Kliknięcie prawym przyciskiem myszki na kulkę ma zakończyć jej wątek. Kulki mają się rysować (i mazać w miarę poruszania - użyć trybu setXORMode) w panelu  Playground. Aby dokonać operacji graficznych na Panelu można raz zachować obiekt klasy  Graphics wywołując na panelu metodę getGraphics. Sam panel, na którym ma się odrysowywać kulka można podać jako argument konstruktora. Wykorzystać metody  java.awt.Graphics.fillOval / fillArc, clearRect i  java.awt.Component.getBackground(). Zapoznać się z dokumentem "Java Thread Primitive Deprecation".

Dodać prostokątny obszar (klasa Box) wewnątrz okienka. Program ma realizować następujące warianty (użyć komponentu javax.swing.JComboBox):

W Boxie może się znajdować (jednocześnie) co najwyżej jedna kulka, reszta czeka przyklejona do ścianek (wywołujemy wait() na objekcie box). Gdy ta wyleci, wpuszczana jest następna (wywołujemy notify() na obiekcie box), itd. Wykorzystać metody  java.lang.Object.wait() i java.lang.Object.notify(). Napisać metody enter() i exit() z modyfikatorem synchronized dla klasy Box.

Kulki przyklejają się do ścianek Box. Gdy użytkownik kliknie na Box wpuszczana jest do środka tylko jedna kulka. Reszta czeka na kolejne kliknięcie.

Kulki przyklejają się do ścianek Boxu. Gdy użytkownik kliknie na Box wpuszczana jest do środka tylko jedna kulka. Gdy ta wyleci, wpuszczana jest następna oczekująca, itd. Gdy Box pozostanie pusty kulki znów przyklejają się do ścianki. Napisać odpowiedni blok  synchronized(box){ ... } wewnątrz pętli w metodzie run() kulki.

Kulki przyklejają się do ścianek Box. Gdy użytkownik kliknie na Box wpuszczane są do środka wszystkie oczekujące kulki. Nowe kulki oczekują na wpuszczenie.
Wykorzystać metody java.lang.Object.wait() i java.lang.Object.notifyAll().

Box co 3s wpuszcza jedną kulkę oczekującą. Box również ma być wątkiem.
Box co 3s wpuszcza wszystkie oczekujące kulki. Box również ma być wątkiem.

Wskazówki

Klasa Thread i wątki:
```
void start() — uruchomienie wątku,
void stop() — zakończenie działania wątku,
void run() — metoda wykonywana przez wątek (główny program wątku),
void suspend() — zawieszenie wąteku (wątek nie zwalnia blokad),
void resume() — wznawienie wykonywania zawieszonego wątku,
void interrupt() — przerwanie oczekiwanie wątku w stanie zablokowania.
```
Wzajemne wykluczanie wątków jest realizowane przez metody synchronized i blok  synchronized.
Metody synchronizowane i bloki synchronizowane blokują obiekt (monitor) dla siebie i są wykonywane atomowo. Jednocześnie tylko jedna taka metoda lub blok może być wykonywany (na danym monitorze). Blok synchronized jest użyteczny do synchronizacji dostępu do już istniejących obiektów, do których nie można dodać żadnych metod.

Synchronizacja wątków:
```
obj.wait() - powoduje uśpienie wątku, który wywołał metodę wait(), w kolejce związanej z monitorem obj. Zwalnia monitor w trakcie uśpienie wątku.
obj.notify() - budzi jeden (losowy) wątek spośród oczekujących w kolejce wait związanej z monitorem obj. Obudzony wątek oczekuje aż wątek wywołujący notify() zwolni monitor.
obj.notifyAll() - budzi wszystkie uśpione wątki i oczekujące w kolejce związanej z monitorem  obj.
```
Metody wait(), notify() i notifyAll() są wywoływane na monitorze i muszą być w jego posiadaniu (metoda lub block synchronized). Metody te należą do klasy  java.lang.Object, w związku z czym monitorem może być każdy obiekt.

credit:   
Andrzej Görlich   
andrzej.goerlich@uj.edu.pl   
http://th.if.uj.edu.pl/~atg/Java
