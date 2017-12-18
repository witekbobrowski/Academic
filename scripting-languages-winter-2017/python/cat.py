#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Concatenate file and print

import sys
import argparse as ap
import mimetypes as mt

def setup_parser():
    parser = ap.ArgumentParser()
    parser.add_argument('-N', help="Will include lines starting with '#'.", dest='should_omit_comments', action='store_false')
    parser.add_argument('-v', help="Won't number lines.", dest='should_number_lines', action='store_false')
    parser.add_argument('-f', help="Force open file.", dest='should_force_open', action='store_true')
    parser.add_argument('files', help="File to be opened.", nargs='*', action="store")
    return parser.parse_args()

def is_textfile(file):
    mime = mt.guess_type(file)
    return mime[0].startswith("text")

def open_and_print(file, should_number_lines = True, should_omit_comments = True, should_force_open = False):
    number = 0
    if not is_textfile(file) and not should_force_open:
        print("\nError: Could not print file:", file, "because it is not a text file.\n")
        return
    with open(file, 'r') as file:
        for line in file:
            if should_omit_comments and line.startswith("#"):
                continue
            output = line
            if should_number_lines:
                output = str(number) + " " + output
                number += 1
            print(output, end="")

result = setup_parser()
for file in result.files:
    open_and_print(file, result.should_number_lines, result.should_omit_comments, result.should_force_open)
