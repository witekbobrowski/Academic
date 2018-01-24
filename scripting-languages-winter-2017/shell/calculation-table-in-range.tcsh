#!/usr/bin/env tcsh
# Witold Bobrowski ; Group 2
#
# Print table of desired calculation on two numbers with given range

# VARIABLES (with default values)

# Number used as a first argument
set a = ""
# Number used as a second argument
set b = ""
# The operation performed on numbers
set calculation_operator = ""
# Will be used to calculate spacing for output
set length_of_longest_result = 0
# Used in the 'for' loop to determine in which direction should it go
set longest_argument = ""

# Main program

VALIDATE_ARGUMENTS:
	foreach argument ($1 $2 $3)
		set is_numerical = `echo $argument | egrep -e '^[+|-]*[0-9]+$'`
		if ( $is_numerical ) then
			if ( $a == "" ) then
				set a = "$argument"
			else if ( $b == "" ) then
				set b = "$argument"
			else
				goto HELP
			endif
		else if ( $argument == "add" ) then
			set calculation_operator = "+"
		else if ( $argument == "sub" ) then
			set calculation_operator = "-"
		else if ( $argument == "mul" ) then
			set calculation_operator = "*"
		else if ( $argument == "div" ) then
			set calculation_operator = "/"
		else if ( $argument == "mod" ) then
			set calculation_operator = "%"
		else if ( $argument == "eq" ) then
			set calculation_operator = "=="
		else if ( $argument == "sm" ) then
			set calculation_operator = "<"
		else if ( $argument == "smeq" ) then
			set calculation_operator = "<="
		else if ( $argument == "gr" ) then
			set calculation_operator = ">"
		else if ( $argument == "greq" ) then
			set calculation_operator = ">="
		else
			goto HELP
		endif
	end

DETERMINE_LONGEST_RESULT:
	@ a_square = ( $a * $a )
	set a_square = `echo $a_square | awk '{print length($0)}'`
	@ b_square = ( $b * $b )
	set b_square = `echo $b_square | awk '{print length($0)}'`
	@ a_times_b = ( $a * $b )
	set a_times_b = `echo $a_times_b | awk '{print length($0)}'`
	if ( $a_square < $b_square ) then
		set length_of_longest_result = $b_square
	else
		set length_of_longest_result = $a_square
	endif
	if ( $length_of_longest_result < $a_times_b ) then
		set length_of_longest_result = $a_times_b
	endif

PRINT_HEADER:
	set buffer = ""
	set length_of_result = `echo \* | awk '{print length($0)}'`
	@ space_count = ( $length_of_longest_result - $length_of_result + 1)
	foreach time (`seq 1 $space_count`)
		set buffer = "$buffer "
	end
	set buffer = "$buffer$calculation_operator "
	foreach b (`seq $a $b`)
		set length_of_result = `echo $b | awk '{print length($0)}'`
		@ space_count = ( $length_of_longest_result - $length_of_result + 1 )
		foreach time (`seq 1 $space_count`)
			set buffer = "$buffer""_"
		end
		set buffer = "$buffer$b"
	end
	echo "$buffer"

TABLE:
	foreach first (`seq $a $b`)
		set buffer = ""
		set length_of_result = `echo $first | awk '{print length($0)}'`
		@ space_count = ( $length_of_longest_result - $length_of_result + 1)
		foreach time (`seq 1 $space_count`)
			set buffer = "$buffer"" "
		end
		set buffer = "$buffer$first""|"
	  foreach second (`seq $a $b`)
			@ result = ( $first $calculation_operator $second )
			set length_of_result = `echo $result | awk '{print length($0)}'`
			@ space_count = ( $length_of_longest_result - $length_of_result + 1)
			foreach time (`seq 1 $space_count`)
				set buffer = "$buffer"" "
			end
			set buffer = "$buffer$result"
	  end
	  echo "$buffer"
	end
	exit

HELP:
	echo "Error: wrong arguments. Please pass two numbers and one of the operators listed below"
	echo
	echo "Usage: ./calculation-table-in-range.tcsh [number] [number] [operation]"
	echo
	echo "Available operators:"
	echo "	add (Addition)"
	echo "	sub (Subtraction)"
	echo "	mul (Multiplication)"
	echo "	div (Division)"
	echo "  mod (Modulo)"
	echo "	eq (Is equal)"
	echo "	sm (Is smaller)"
	echo "	smeq (Is smaller or equal)"
	echo "	gr (Is greater)"
	echo "	greq (Is greater or equal)"
	echo
	echo "Note: order of arguments is not strictly defined, and any special characers need to be escaped with '\\'"
	echo
	echo "Example: ./calculation-table-in-range.tcsh 1 % 15"
	echo
	set a = 1
	set b = 15
	set calculation_operator = "%"
	goto DETERMINE_LONGEST_RESULT
