#!/usr/bin/env bash
# Witold Bobrowski ; Group 2

# FUNCTIONS
quiet() {
	exit $error
}
display_help() {
	echo "Usage: ./whoami-bash.sh [--help] [-h] [--quiet] [-q]"
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
# VARIABLES
# error variable which will be returned on exit.
error=0
# variable to store a flag that was passed as an argument but is not defined.
program_should_exit="false"

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
