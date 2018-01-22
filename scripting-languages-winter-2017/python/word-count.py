#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Print word count for input files

import sys
import argparse as ap
import utils

# CONSTANTS
FILE, WORDS, LINES, CHARS, BYTES, INTS, NUMS = "file", "words", "lines", "chars", "bytes", "ints", "nums"

# VARIABLES
total_count = {LINES: 0, WORDS: 0, CHARS: 0, BYTES: 0, INTS: 0, NUMS: 0}
# Longest result
long_res = 0

# FUNCTIONS


def setup_parser():
    parser = ap.ArgumentParser()
    parser.add_argument('-e', '--comments', help="Will ignore lines starting with #",
                        dest='should_ignore_comments', action='store_true')
    parser.add_argument('-l', '--lines', help="Print number of lines",
                        dest='should_print_lines', action='store_true')
    parser.add_argument('-w', '--words', help="Print number of words",
                        dest='should_print_words', action='store_true')
    parser.add_argument('-m', '--chars', help="Print number of characters",
                        dest='should_print_characters', action='store_true')
    parser.add_argument('-c', '--bytes', help="Print number of bytes",
                        dest='should_print_bytes', action='store_true')
    parser.add_argument('-i', '--ints', help="Print number of integers",
                        dest='should_print_ints', action='store_true')
    parser.add_argument('-n', '--nums', help="Print number of numbers in any of the following formats: e/E/d/D/q/Q",
                        dest='should_print_nums', action='store_true')
    parser.add_argument('files', help="Files to evaluate.",
                        nargs='*', action="store")
    return parser.parse_args()


def evaluate_options(arguments):
    options = {arguments.should_print_lines, arguments.should_print_words, arguments.should_print_characters,
               arguments.should_print_bytes, arguments.should_print_ints, arguments.should_print_nums}
    for option in options:
        if option:
            return
    # If none of the options was chosen, turn on default ones
    arguments.should_print_lines = True
    arguments.should_print_words = True
    arguments.should_print_characters = True


def compare_to_longest_string(strings):
    global long_res
    for string in strings:
        long_res = len(str(string)) if len(
            str(string)) > long_res else long_res


def format_result(string):
    n = long_res - len(str(string))
    spaces = " " * n
    return spaces + str(string)


def word_count(file, should_ignore_comments):
    global total_count
    count = {FILE: file, LINES: 0, WORDS: 0, CHARS: 0, BYTES: 0, INTS: 0, NUMS: 0}
    with open(file, 'r') as file:
        count[FILE] = file.name
        for line in file:
            if should_ignore_comments and line.startswith("#"):
                continue
            words = line.split()
            count[LINES] += 1
            count[WORDS] += len(words)
            count[CHARS] += len(line)
            count[BYTES] += sys.getsizeof(line)
            for word in words:
                if utils.looks_like_number(word):
                    count[NUMS] += 1
                    if utils.looks_like_integer(word):
                        count[INTS] += 1
    for key in total_count:
        total_count[key] += count[key]
        compare_to_longest_string([total_count[key]])
    return count


def get_output(options, result):
    output = ""
    if options.should_print_lines:
        output += "    " + str(format_result(result[LINES]))
    if options.should_print_words:
        output += "    " + str(format_result(result[WORDS]))
    if options.should_print_characters:
        output += "    " + str(format_result(result[CHARS]))
    if options.should_print_bytes:
        output += "    " + str(format_result(result[BYTES]))
    if options.should_print_ints:
        output += "    " + str(format_result(result[INTS]))
    if options.should_print_nums:
        output += "    " + str(format_result(result[NUMS]))
    output += " " + result[FILE]
    return output


# Main
if __name__ == "__main__":
    arguments = setup_parser()
    evaluate_options(arguments)
    results = [word_count(file, arguments.should_ignore_comments)
               for file in arguments.files]
    for result in results:
        print(get_output(arguments, result))
    if len(results) > 1:
        total_count[FILE] = "total"
        print(get_output(arguments, total_count))
