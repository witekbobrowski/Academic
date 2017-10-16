#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Print table of desired calculation on two numbers with given range

# VARIABLES (with default values)

# Number used as a first argument
a=""
# Number used as a second argument
b=""
# The operation performed on numbers
calculation_operator=""
# Used in the 'for' loop to determine in which direction should it go
comparsion_operator="<="
# Used in the 'for' loop to determine the way current position should change
change_operator="++"
# Will be used to calculate spacing for output
length_of_longest_result=1

# FUNCTIONS

# Accumulate buffer with new value and proper spacing
# Arguments:
#	1) Separator that will be used as spacing
#   2) A number that should be added to the buffer
#   3) Optional suffix that will be added directly after the first argument
reduce_with_separator() {
	local space_separator="$(printf "%$(($(($length_of_longest_result - ${#2} + 1))))s")"
	buffer+="${space_separator// /$1}"$2$3
}

# Print table header
# Arguments:
#   1) First number to determine the range
#   2) Second number to determine the range
#	3) Operator for the loop to determine in which direction should it go
#	3) Operator for the loop to determine the way current position should change
print_table_header() {
	buffer=""
	reduce_with_separator " " "$calculation_operator" " "
	for ((j = $1; $(($j $3 $2)); $(($4j)))); do
		reduce_with_separator "_" $j
	done
	echo "$buffer"
}

# Print operation table
# Arguments:
#   1) First number to determine the range
#   2) Second number to determine the range
#	3) Operator for the loop to determine in which direction should it go
#	3) Operator for the loop to determine the way current position should change
print_operation_table() {
	for ((i = $1; $(($i $3 $2)); $(($4i)))); do
		buffer=""
		reduce_with_separator " " $i "|"
  		for ((j = $1; $(($j $3 $2)); $(($4j)))); do
    		reduce_with_separator " " $(( $i $calculation_operator $j ))
		done
    	echo "$buffer"
	done
}

# For the sake of nice and readable output
# Arguments:
#   1) Number that then will be powered to determine the length of the longest result in table
define_longest_result_length() {
	local result=""
	case "$calculation_operator" in
		"**"|"*"|"+") (( $1 < $2 )) && result=$(($2 $calculation_operator $2)) || result=$(($1 $calculation_operator $1)) ;;
		"-") (( $1 < $2 )) && result=$((0 $calculation_operator $2)) || result=$((0 $calculation_operator $1)) ;;
		"%") (( $1 < $2 )) && result=$(($2 $calculation_operator $2 - 1)) || result=$(($1 $calculation_operator $2 - 1)) ;;
		"=="|">"|"<"|">="|"<="|"/") (( $1 < $2 )) && result=$(($2)) || result=$(($1)) ;;
	esac
	length_of_longest_result=${#result}
}

display_error() {
	echo "Error: wrong arguments. Please pass two numbers and one of the operators listed below"
	echo
	echo "Usage: ./calculation-table-in-range-bash.sh [number] [number] [operation]"
	echo
	echo "Available operators:"
	echo "	+ (Addition)"
	echo "	- (Subtraction)"
	echo "	* (Multiplication)"
	echo "	/ (Division)"
	echo "	% (Modulo)"
	echo "	** (Exponentiation)"
	echo "	== (Is equal)"
	echo "	< (Is smaller)"
	echo "	<= (Is smaller or equal)"
	echo "	> (Is greater)"
	echo "	>= (Is greater or equal)"
	echo
	echo "Note: order of arguments is not strictly defined, any any special characers need to be escaped with '\\'"
	echo
	echo "Example: ./calculation-table-in-range-bash.sh 1 * 15"
	echo
	a=1
	b=15
	calculation_operator="*"
	validate_arguments_order $a $b
	define_longest_result_length $a $b
	print_table_header $a $b $comparsion_operator $change_operator
	print_operation_table $a $b $comparsion_operator $change_operator
	echo  >&2; exit 1
}

# Check if arguments containt 2 numbers and operator
# Arguments:
#   1) First argument of the program
#   1) Second argument of the program
validate_arguments() {
	local is_numerical='^[+|-]*[0-9]+$'
	local is_operator='^[\+-\/\*\%\>\<]$|^\*{2}$|^\<\=$|^\>\=$|^\=\=$'
	for argument in "$1" "$2" "$3"; do
		if [[ $argument =~ $is_numerical ]]; then
			if [[ $a = "" ]]; then
				a=$argument
			else
				b=$argument
			fi
		elif [[ $argument =~ $is_operator ]]; then
			calculation_operator=$argument
		else
			display_error
		fi
	done
}

# Set variables to print multiplication table correctly
# Arguments:
#   1) First argument of the program; that is already a verified number
#   1) Second argument of the program; that is already a verified number
validate_arguments_order() {
	(( $1 < $2 )) && comparsion_operator="<=" || comparsion_operator=">="
	(( $1 < $2 )) && change_operator="++" || change_operator="--"
}

# Main program
validate_arguments "$1" "$2" "$3"
validate_arguments_order $a $b
define_longest_result_length $a $b
print_table_header $a $b $comparsion_operator $change_operator $calculation_operator
print_operation_table $a $b $comparsion_operator $change_operator $calculation_operator
