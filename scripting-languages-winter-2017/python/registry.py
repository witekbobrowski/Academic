#!/usr/bin/env python3
# Witold Bobrowski ; Group 2
#
# Parse text file of students with grades and generate registry

import sys
import argparse as ap
import utils
import ntpath

# CONSTANTS
GRADE, NAME = "grade", "name"

# VARIABLES
longest = {GRADE: 0, NAME: 0}

# FUNCTIONS


def setup_parser():
    parser = ap.ArgumentParser()
    parser.add_argument('files', help="Files to evaluate.",
                        nargs='*', action="store")
    return parser.parse_args()


def evaluate_input_file(file):
    registry = {}
    global longest
    with open(file, 'r') as file:
        for line in file:
            words = line.split()
            name = words[1].lower() + "-" + words[0].lower()
            longest[NAME] = len(str(name)) if len(
                str(name)) > longest[NAME] else longest[NAME]
            grade = utils.get_grade(words[2])
            if grade == 0:
                utils.eprint(
                    "WARNING! \"" + words[2] + "\" is not a valid grade, therefore it will be ignored\n")
            else:
                longest[GRADE] = len(str(grade)) if len(
                    str(grade)) > longest[GRADE] else longest[GRADE]
                registry.setdefault(name, []).append(grade)
    return registry


def format_string(string, separator, longest):
    n = longest - len(str(string))
    spaces = separator * n
    return spaces + str(string)


def generate_output_from(registry, file_name):
    output = ""
    total_sum, total_grades_count = 0, 0
    for key in sorted(registry):
        sum, grades_count = 0, 0
        names = key.split("-")
        output += "    " + format_string(names[0].capitalize() + " " +
                                names[1].capitalize(), " ", longest[NAME]) + "    [ "
        for grade in registry[key]:
            sum += float(grade)
            grades_count += 1
            output += format_string(grade, " ", longest[GRADE]) + ", "
        output += "] Average: " + str(sum / grades_count) + "\n"
        total_sum += sum
        total_grades_count += grades_count
    header = format_string(file_name, "-", longest[NAME]) + \
        " - Average for all students: " + \
        str(total_sum / total_grades_count) + "\n"
    return header + output


# Main
if __name__ == "__main__":
    arguments = setup_parser()
    for file in arguments.files:
        registry = evaluate_input_file(file)
        print(generate_output_from(registry, ntpath.basename(file)))
