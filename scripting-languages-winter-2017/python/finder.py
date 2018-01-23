#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Search through directories for given phrase

import sys
import os

# VARIABLES
should_indicate_lines = False

# FUNCTIONS


def evaluate_arguments(args):
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
            should_indicate_lines = True
        else:
            paths[argument] = current_directories
            current_directories = []
    return paths


def walk(string, dirs):
    results = []
    for dir in dirs:
        for dirname, dirnames, filenames in os.walk(dir):
            for filename in filenames:
                results.append(find(string, os.path.join(dirname, filename)))


def find(string, file):


# Main
if __name__ == "__main__":
    paths = evaluate_arguments(sys.argv[1:])
    for key in paths:
        walk(key, paths[key])
