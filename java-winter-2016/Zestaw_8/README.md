# Zestaw 8

![native](/Java/Zestaw_8/native.png)

## Native

Example of C methods used in Java code using Color enum from one of the previous tasks.

## What's included

```
native/
├── Palette.c
└── Palette.java
```

## Usage

1. Generate header Palette.h

  ```
  javah -jni Palette
  ```

2. Compile Palette.c
    * On Mac
  ```
  gcc -shared -fPIC -I/Library/Java/JavaVirtualMachines/jdk1.8.0_65.jdk/Contents/Home/include -I/Library/Java/JavaVirtualMachines/jdk1.8.0_65.jdk/Contents/Home/include/darwin -I/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/MacOS Palette.c -o libPalette.dylib
  ```
    * On Linux
  ```
  gcc -shared -fPIC -I/opt/java/include -I/opt/java/include/linux Palette.c -o libPalette.dylib
  ```

3. Compile Palette.java

  ```
  javac Palette.java
  ```

4. Export PATH

  ```
  export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH
  ```

5. Run

  ```
  java Palette
  ```
