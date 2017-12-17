#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Evaluate quadratic equation

import math
import sys

def quadratic_equation(a = 1, b = -1, c = -2):
    𝛥 = (b * b) - (4 * a * c)
    if 𝛥 > 0:
        x1 = (-b + math.sqrt(𝛥)) / (2 * a)
        x2 = -(b + math.sqrt(𝛥)) / (2 * a)
        return (x1, x2)
    elif 𝛥 == 0:
        return -b / (2 * a)
    else:
        return "two complex roots"

def is_float(value):
  try:
    float(value)
    return True
  except ValueError:
    return False

def evaluate_arguments(args):
    for arg in ["a", "b", "c"]:
        if arg in args:
            if (arg == "a" and float(args[arg]) == .0):
                print("'a' cannot be equal to zero, please try a different number")
            elif not is_float(args[arg]):
                print("you have to give me a valid floating point number!")
            else:
                args[arg] = float(args[arg])
                continue
        print("Please enter number for", arg, ":", end=" ")
        args[arg] = float(input())
    return args

arguments = dict(a.split("=") for a in sys.argv[1:])
arguments = evaluate_arguments(arguments)
print("Function:", arguments["a"],"* x^2 +", arguments["b"], "* x +", arguments["c"])
print("Solution:", quadratic_equation(arguments["a"], arguments["b"], arguments["c"]))
