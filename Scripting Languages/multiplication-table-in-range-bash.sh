#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Print multiplication table with given range

# VARIABLES (with default values)

# Will be used to calculate spacing for output
length_of_longest_result=0
# Used in the 'for' loop to determine in which direction should it go
comparsion_operator="<="
# Used in the 'for' loop to determine the way current position should change
change_operator="++"

# FUNCTIONS

# Accumulate buffer with new value and proper spacing
# Arguments:
#   1) A number that should be added to the buffer
#   2) Oprional suffix that will be added directly after the first argument
reduce() {
	local space_count="$(printf "%$(($(($length_of_longest_result - ${#1} + 1))))s")"
	buffer+="${space_count// /" "}"$1$2
}

# Print multiplication table
# Arguments:
#   1) First number to determine the range
#   2) Second number to determine the range
#	3) Operator for the loop to determine in which direction should it go
#	3) Operator for the loop to determine the way current position should change
print_multiplication_table() {
 	for ((i = $1; $(($i $3 $2)); $(($4"i")))); do
		buffer=""
		reduce $i "|"
    	for ((j = $1; $(($j $3 $2)); $(($4"j")))); do
      		reduce $(( $i * $j ))
    	done
    	echo "$buffer"
  	done
}

# For the sake of nice and readable output
# Arguments:
#   1) Number that then will be powered to determine the length of the longest result in table
define_longest_result_length() {
	local result=$(($1 ** 2))
	length_of_longest_result=${#result}
}


# Check if arguments are numbers, otherwise print error
# Arguments:
#   1) First argument of the program
#   1) Second argument of the program
validate_arguments_types() {
	local is_numerical='^[+|-]*[0-9]+$'
	if ! [[ $1 =~ $is_numerical ]] || ! [[ $2 =~ $is_numerical ]]; then
   		echo "error: You have to use a pair of numbers as input!" >&2; exit 1
	fi
}

# Set variables to print multiplication table correctly
# Arguments:
#   1) First argument of the program; that is already a verified number
#   1) Second argument of the program; that is already a verified number
validate_arguments_order() {
	(( $1 < $2 )) && define_longest_result_length $2 || define_longest_result_length $1
	(( $1 < $2 )) && comparsion_operator="<=" || comparsion_operator=">="
	(( $1 < $2 )) && change_operator="++" || change_operator="--"
}

# Main program

validate_arguments_types $1 $2
validate_arguments_order $1 $2
print_multiplication_table $1 $2 $comparsion_operator $change_operator
