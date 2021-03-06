#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Display current user

# VARIABLES
# error variable which will be returned on exit.
error=0
# variable to store a flag that was passed as an argument but is not defined.
program_should_exit="false"

# FUNCTIONS
quiet() {
    exit $error
}

display_help() {
    echo "whoami.tcsh -- print current user"
    echo
    echo "Usage: ./whoami.bash [--help] [-h] [--quiet] [-q]"
    echo
    echo "Options:"
    echo "	-h | --help 	Show help"
    echo "	-q | --quiet 	exit"
    quiet
}

display_user() {
    whoami
}

error() {
    error=1
    if [[ $1 != "" ]]; then
        echo -e "[!] Unknown command: \`$1\`"
        echo
        display_help
    fi
}

# Main program

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) display_help ;;
        -q|--quiet)
            program_should_exit="true"
            shift
            ;;
        -*) error $1 ;;
        *) shift ;;
    esac
done

if [[ $program_should_exit != "true" ]]; then
    display_user
fi
quiet
