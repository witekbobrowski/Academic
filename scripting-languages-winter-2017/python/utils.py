import re
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

# regexp's from https://docstore.mik.ua/orelly/perl4/cook/ch02_02.htm
