#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Search through directories for given phrase

import sys
import os
import ntpath

# VARIABLES
should_print_lines = False

# FUNCTIONS


def evaluate_arguments(args):
    global should_print_lines
    paths = {}
    expecting_directory = False
    current_directories = []
    for argument in args:
        if argument == "-d":
            expecting_directory = True
        elif expecting_directory:
            current_directories.append(argument)
            expecting_directory = False
        elif argument == "-v":
            should_print_lines = True
        else:
            paths[argument] = current_directories
            current_directories = []
    return paths


def walk(pattern, dir):
    results = []
    for dirname, dirnames, filenames in os.walk(dir):
        for filename in filenames:
            results.append(find(pattern, os.path.join(dirname, filename)))
    return results


def find(pattern, filename):
    lines = []
    if ntpath.basename(filename)[0] == '.':
        return
    with open(filename, 'r') as file:
        for line in file:
            lines.append(line.replace('\n', ' ').replace('\r', '').replace(pattern, '\x1b[6;30;42m' + pattern + '\x1b[0m'))
    return (filename, lines)


def print_results(results):
    for result in results:
        if result == None:
            continue
        for line in result[1]:
            print(result[0] + ":" + line)


# Main
if __name__ == "__main__":
    paths = evaluate_arguments(sys.argv[1:])
    for key in paths:
        for dir in paths[key]:
            print_results(walk(key, dir))
