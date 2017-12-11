#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Print multiplication table

import sys

def print_multiplication_table(end):
    spacing = len(str(end*end))
    print(" " * (spacing + 1)," |", end= "")
    for num in range(1, end+1):
        print("_" * (spacing - len(str(num))), num, end="")
    for a in range(1, end+1):
        print("\n"," " * (spacing - len(str(a))), a, "|", end= "")
        for b in range(1, end+1):
            res = a*b
            print(" " * (spacing - len(str(res))), res, end="")

print_multiplication_table(int(sys.argv[1]))
