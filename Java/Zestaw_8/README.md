#Zestaw 8
![alt tag](/Java/Zestaw_8/native.png)

to run on Mac go to terminal and type
```
gcc -shared -fPIC -I/Library/Java/JavaVirtualMachines/jdk1.8.0_65.jdk/Contents/Home/include -I/Library/Java/JavaVirtualMachines/jdk1.8.0_65.jdk/Contents/Home/include/darwin -I/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/MacOS Palette.c -o libPalette.dylib
```

```
export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH
```


Klasy umieścić w pakiecie reflection.
Dodać komentarze i użyć narzędzia javadoc do wygenerowania dokumentacji.
Szczegóły dotyczące programowania refleksyjnego w Javie można znaleźć w wykładzie.

###Zadanie 1.

####Paleta.java

Napisać prostą metodę natywną Javy (np. o nazwie printText) w języku C. Metoda ma za zadanie wypisać nazwy i skład r, g, b wszystkich elementów typu wyliczeniowego Kolor z zestawu 5 i zaznaczyć kolor przekazany jako argument.

W tym celu należy wykonać następujące kroki:

W pliku Paleta.java stworzyć publiczną klasę Paleta.
Zadeklarować w niej metodę natywną

public native void printText(Kolor c);
Jawnie załadować natywną bibliotekę z kodem w bloku statycznym. Nazwa biblioteki (wielkość liter) musi odpowiadać nazwie biblioteki, którą stworzymy w dalszych punktach.
```
static
{
  System.loadLibrary("Paleta");
}
```
Napisać funkcję statyczną main, stworzyć obiekt klasy Paleta i wywołać metodę printText.
```
Paleta picasso  = new Paleta();
picasso.printText(Kolor.BLUE);
```
Skompilować klasę i utworzyć plik Paleta.class
```
javac Paleta.java
```
Utworzyć plik nagłówkowy Paleta.h zawierający deklaracje funkcji natywnej
```
javah -jni Paleta
```

####Paleta.c

Utworzyć plik źródłowy Paleta.c w języku C zawierający ciało funkcji
```
JNIEXPORT void JNICALL
  Java_Paleta_printText (JNIEnv *env, jobject obj, jobject c)
   {...}
```
Argument obj odnosi się do obiektu this, a argument c do obiektu klasy Kolor.
Na początku pliku włączyć plik nagłówkowy Paleta.h
Aby uzyskać tablicę wszystkich elementów typu Kolor należy wywołać metodę statyczną  Kolor[] values()
```
jclass    cls = (*env)->GetObjectClass(env, c);
  // Pobranie obiektu klasy ('Kolor') dla obiektu 'c'
jmethodID mid = (*env)->GetStaticMethodID(env, cls, "values", "()[LKolor;");
  // Pobranie identyfikatora metody 'values' w klasie 'Kolor'
jobjectArray joa = (*env)->CallStaticObjectMethod(env, c, mid);
  // Pobranie wyniku metody 'values' czyli tablicy wszystkich kolorow
int len = (*env)->GetArrayLength(env, joa);
  // Pobranie dlugosci tablicy
```
Każda z powyższych funkcji zwraca wartość null w przypadku błedu.
Aby otrzymać i-ty element tablicy należy użyć funkcji
```
jobject elem = (*env)->GetObjectArrayElement(env, joa, i);
```
Aby odczytać pola r, g, b obiektu klasy Kolor (np. zmiennej c lub elem) tworzymy identyfikator pola (wystarczy jednorazowo na początku) i używamy funkcji GetDoubleField
```
jfieldID  fidr = (*env)->GetFieldID(env, cls, "r", "D");
jdouble r = (*env)->GetDoubleField(env, elem, fidr);
  // To samo co typ 'double'
```
Nazwę koloru odczytujemy wywołując metodę niestatyczną String name() i zamieniając wynik na ciąg znaków char*. Gdy napis przestanie być potrzebny należy zwolnić zaalokowaną pamięć
```
jmethodID mid = (*env)->GetMethodID(env, cls, "name", "()Ljava/lang/String;");
jstring jstr  = (*env)->CallObjectMethod(env, elem, midname);
const char* str = (*env)->GetStringUTFChars(env, jstr, NULL);
...
(*env)->ReleaseStringUTFChars(env, jstr, str);
```
Po napisaniu programy kompilujemy kod i tworzymy bibliotekę dynamiczną libPaleta.so. Aby móc jej używać należy ustawić odpowiednie zmienne środowiskowe (bash).
```
gcc -shared -fPIC -I/opt/java/include -I/opt/java/include/linux Paleta.c -o libPaleta.so
LD_LIBRARY_PATH=.
export LD_LIBRARY_PATH
```
Uruchamiamy program.

credit:   
Andrzej Görlich   
andrzej.goerlich@uj.edu.pl   
http://th.if.uj.edu.pl/~atg/Java
