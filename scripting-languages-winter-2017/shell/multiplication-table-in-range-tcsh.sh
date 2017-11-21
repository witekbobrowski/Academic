#!/usr/bin/env tcsh
# Witold Bobrowski ; Group 2
#
# Print multiplication table with given range

# VARIABLES (with default values)

# Will be used to calculate spacing for output
set length_of_longest_result = 0
# Used in the 'for' loop to determine in which direction should it go
set longest_argument = ""

# Main program

VALIDATE_ARGUMENTS_TYPES:
	set a_is_numerical = `echo $1 | egrep -e '^[+|-]*[0-9]+$'`
	set b_is_numerical = `echo $2 | egrep -e '^[+|-]*[0-9]+$'`
	if ( ! ($a_is_numerical) || ! ($b_is_numerical) ) then
		echo "error: You have to use a pair of numbers as input!"
		exit 1
	endif

DETERMINE_LONGEST_RESULT:
	@ a_square = ( $1 * $1 )
	set a_square = `echo $a_square | awk '{print length($0)}'`
	@ b_square = ( $2 * $2 )
	set b_square = `echo $b_square | awk '{print length($0)}'`
	@ a_times_b = ( $1 * $2 )
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
	set buffer = "$buffer""*"" "
	foreach b (`seq $1 $2`)
		set length_of_result = `echo $b | awk '{print length($0)}'`
		@ space_count = ( $length_of_longest_result - $length_of_result + 1 )
		foreach time (`seq 1 $space_count`)
			set buffer = "$buffer""_"
		end
		set buffer = "$buffer$b"
	end
	echo "$buffer"

TABLE:
	foreach a (`seq $1 $2`)
		set buffer = ""
		set length_of_result = `echo $a | awk '{print length($0)}'`
		@ space_count = ( $length_of_longest_result - $length_of_result + 1)
		foreach time (`seq 1 $space_count`)
			set buffer = "$buffer"" "
		end
		set buffer = "$buffer$a""|"
	  foreach b (`seq $1 $2`)
			@ result = ( $a * $b )
			set length_of_result = `echo $result | awk '{print length($0)}'`
			@ space_count = ( $length_of_longest_result - $length_of_result + 1)
			foreach time (`seq 1 $space_count`)
				set buffer = "$buffer"" "
			end
			set buffer = "$buffer$result"
	  end
	  echo "$buffer"
	end
