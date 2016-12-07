#Zestaw 3
![alt tag](/Java/Zadanie_3/Mandelbrot.png)
Język Java
Termin: 09.11.2016

Pliki źródłowe umieścić w katalogu mandelbrot, a klasy w pakiecie o tej samej nazwie.
Dodać komentarze i użyć narzędzia javadoc do wygenerowania dokumentacji.

###Zadanie 1. Mandelbrot

Proszę zapoznać się z definicją zbioru Mandelbrota i napisać program, który ten zbiór rysuje. Wykorzystać własną klasę Complex z poprzedniego zestawu. Kolorem czarnym proszę rysować te punkty p w płaszczyźnie zespolonej, dla której ciąg zn + 1 = zn2 + p nie dąży do ∞. Dla pozostałych punktów, kolor uzależnić od prędkości ucieczki (jak szybko, czyli minimalne n, dla którego SqrAbs(zn) jest większe od pewnego progu r2 - ma to być parametr, domyślnie np. 4). Proszę korzystać z formatu RGB i wymyśleć ładną funkcję kolorującą. Ograniczyć się do maksymalnie ok. 100 iteracji ciągu zn, aby określić czy ciąg jest rozbieżny.

Proszę zapoznać się z klasą BufferedImage, która przechowuje dane obrazu. Sugeruję wybrać imageType = TYPE_INT_RGB. Aby postawić pixel (lub prostokątny obszar pixeli) o danym kolorze można użyć metody setRGB.

Proszę napisać klasę ImagePanel, która dziedziczy po klasie JPanel oraz implementuje interfejs MouseMotionListener. Proszę przeciążyć metodę paintComponent(Graphics), tak aby rysowała tło, które jest obrazem (np. typu BufferedImage). Klasa ta ma umożliwiać wybór prostokątnego obszaru (ramka) przy pomocy myszki, należy odpowiednio zaimplementować metodę mouseDragged. Proszę zwrócić uwagę na metodę setXORMode klasy Graphics. Po wybraniu obszaru proszę wywołać metodę regionChoosen() obiektu klasy, która implementuje interfejs RegionChooser. Obiekt ten może zostać przekazany np. jako argument konstruktora ImagePanel. ImagePanel ma rysować szare tło gdy nie wybrano żadnego obrazu (null).

Proszę napisać interfejs RegionChooser.

Napisać klasę Mandelbrot, która dziedziczy po klasie JFrame oraz implementuje interfejsy ActionListener oraz własny interfejs RegionChooser.

Można użyć układacza GridBagLayout wywołując metodę setLayout oraz wykorzystać klasę GridBagConstraints.

Nowe komponenty (przyciski, pola tekstowe, etc.) dodajemy wywołując metodę add. Proszę zwrócić uwagę na metody actionPerformed interfejsu ActionListener, addWindowListener, dispose dla JFrame, addActionListener dla JButton oraz getSource dla ActionEvent.

Dodać pole umożliwiające wybór: zakresu obrazka (czyli zakres p), parametru r, wielkość obrazka (liczba pixeli - width i height), przycisk rysujący fraktal. Dodać pole w której znajduję rysunek fraktala czyli ImagePanel. Umożliwić wybór zakresu obrazka myszką.

Podsumowanie:

Klasa ImagePanel ma rysować obraz i umożliwiać wybór prostokątnego obszaru przy pomocy myszki, wtedy wywołuje metodę regionChoosen klasy Mandelbrot.
Klasa Mandelbrot ma za zadanie zebrać parametry fraktala, wygenerować (policzyć) obrazek typu BufferedImage z fraktalem, uaktualnić ImagePanel aby wyświetlił policzony obraz.

Wskazówki

Przydatne klasy:
```
javax.swing: JFrame, JPanel, JTextField, JLabel, JButton
java.awt: GridBagLayout, BufferedImage
Complex
```
Operacje graficzne wykonujemy na obiekcie klasy java.awt.Graphics, który możemy otrzymać poprzez metodę getGraphics() z klasy JPanel (dziedziczona po JComponent). Metoda setXORMode(Color c) ustawia tryb rysowania XOR, w którym dwukrotne wykonanie tego samego rysunku odtwarza pierwotne kolory.

Zdarzenia generowane przez mysz, potrzebne do rysowania prostokątnej ramki, można obsługiwać na dwa sposoby:

Klasa ImagePanel może implementować wszystkie metody (niektóre puste) z interfejsów MouseListener i MouseMotionListener.
Można stworzyć obiekt anonimowej klasy dziedziczącej po klasie abstrakcyjnej java.awt.event.MouseAdapter (która implementuje powyższe interfejsy) i przeciążyć wymagane metody:
```
panel.addMouseListener(new java.awt.event.MouseAdapter() {
    public void mousePressed(java.awt.event.MouseEvent evt) {
        /* kod */
    }
    /* Implementacja pozostałych wymaganych metod */
});
```
Wewnątrz konstruktora klasy ImagePanel referencje do obiektu panel należy pominąć.

Pożądane ułożenie komponentów w oknie może być dosyć żmudne, dlatego warto stosować metodę małych kroków (np. początkowo tylko ImagePanel). Można użyć innych klas niż GridBagLayout lub narzędzi do tworzenia okien (builderów).

credit:   
Andrzej Görlich   
andrzej.goerlich@uj.edu.pl   
http://th.if.uj.edu.pl/~atg/Java
