#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Evaluate quadratic equation

import math

def quadratic_equation(a = 1, b = -1, c = -2):
    𝛥 = (b * b) - (4 * a * c)
    if 𝛥 > 0:
        x1 = (-b + math.sqrt(𝛥)) / (2 * a)
        x2 = -(b + math.sqrt(𝛥)) / (2 * a)
        return (x1, x2)
    elif delta == 0:
        return -b / (2 * a)
    else:
        return "two complex roots"

print(quadratic_equation())
