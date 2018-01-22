import re
import sys
import mimetypes as mt

# Check if file is a text file
def is_textfile(file):
    mime = mt.guess_type(file)
    return mime[0].startswith("text")

# Check if string looks like integer
def looks_like_integer(string):
    return re.match("^[+-]?\d+$", string)

# Check if string looks like natural number
def looks_like_natural_number(string):
    return re.match("^\d+$", string)

# Check if string looks like decimal number
def looks_like_decimal_number(string):
    return re.match("^-?\d+\.?\d*$", string)

# Check if string looks like number
def looks_like_number(string):
    return re.match("^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$", string)

# Get grade from string
def get_grade(string):
    floating_point, base = 0, 0
    if re.match("^\d*(\.\d*)?$", string):
        base = string
    elif re.match("^\d[-]?$", string):
        base = float(string[:1])
        floating_point = -0.25
    elif re.match("^[-]?\d$", string):
        base = float(string[1:])
        floating_point = -0.25
    elif re.match("^\d[+]?$", string):
        base = float(string[:1])
        floating_point = 0.25
    elif re.match("^[+]?\d$", string):
        base = float(string[1:])
        floating_point = 0.25
    grade = float(base) + float(floating_point)
    return grade if 2 <= grade and grade <= 5 else 0

# Print to STDERR
def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

# regexp's from https://docstore.mik.ua/orelly/perl4/cook/ch02_02.htm
