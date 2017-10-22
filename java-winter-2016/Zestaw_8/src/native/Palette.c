#include <stdio.h>
#include <string.h>
#include "Palette.h"

JNIEXPORT void JNICALL Java_Palette_printText (JNIEnv *env, jobject obj, jobject c){

    jclass jClass = (*env)->GetObjectClass(env, c);

    jfieldID jFieldRed = (*env)->GetFieldID(env, jClass, "r", "D");
    jfieldID jFieldGreen = (*env)->GetFieldID(env, jClass, "g", "D");
    jfieldID jFieldBlue = (*env)->GetFieldID(env, jClass, "b", "D");

    jmethodID values = (*env)->GetStaticMethodID(env, jClass, "values", "()[LColor;");
    jmethodID name = (*env)->GetMethodID(env, jClass, "name", "()Ljava/lang/String;");

    jstring jString  = (*env)->CallObjectMethod(env, c, name);
    const char* string = (*env)->GetStringUTFChars(env, jString, NULL);

    jobjectArray colorArray = (*env)->CallStaticObjectMethod(env, c, values);
    int arrayLength = (*env)->GetArrayLength(env, colorArray);

    printf("┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n┃ Elements of the enum Color ┃\n┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n");

    for (int i = 0; i < arrayLength; i++){

        jobject color = (*env)->GetObjectArrayElement(env, colorArray, i);

        jdouble r = (*env)->GetDoubleField(env, color, jFieldRed);
        jdouble g = (*env)->GetDoubleField(env, color, jFieldGreen);
        jdouble b = (*env)->GetDoubleField(env, color, jFieldBlue);

        jstring colorName = (*env)->CallObjectMethod(env, color, name);
        const char* colorNameString = (*env)->GetStringUTFChars(env, colorName, NULL);

        if(strcmp(string, colorNameString) == 0){
            if (arrayLength == 1)
                printf(" ━━ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
            else if (i == 0)
                printf("┏━━ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
            else if (i == arrayLength - 1)
                printf("┖━━ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
            else
                printf("┣━━ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
        }else{
            if (arrayLength == 1)
                printf(" ┈ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
            else if (i == 0)
                printf("┎┈ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
            else if (i == arrayLength - 1)
                printf("┖┈ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
            else
                printf("┠┈ %s (R: %f G: %f B: %f)\n", colorNameString, r, g, b);
        }

        (*env)->ReleaseStringUTFChars(env, colorName, colorNameString);
    }

    (*env)->ReleaseStringUTFChars(env, jString, string);
}