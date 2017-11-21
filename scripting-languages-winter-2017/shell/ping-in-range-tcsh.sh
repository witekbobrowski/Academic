#!/usr/bin/env tcsh
# Witold Bobrowski ; Group 2
#
# Ping all addresses in given range

# VARIABLES (with default values)

set address_a = (0 0 0 0)
set address_b = (0 0 0 0)
set current_address = (0 0 0 0)
set address_string = ""
set number_of_adresses_to_ping = 0

# Main program

# Transform two strings to arrays
TRANSFROM_AND_COMPARE_ADDRESSES:
	set temp_a = ($1:as/./ /)
	set temp_b = ($2:as/./ /)
	foreach index (`seq 1 4`)
		if ( ${temp_a[$index]} < ${temp_b[$index]} ) then
			set address_a = ($temp_a:q); set address_b = ($temp_b:q); break
		elif ( ${temp_a[$index]} > ${temp_b[$index]} ) then
			set address_a = ($temp_b:q); set address_b = ($temp_a:q); break
		endif
	end
	set current_address = ($address_a)

# Calculate how many adresses should be pinged
CALCULATE_NUMBER_OF_ADDRESSES_TO_PING:
	set decimal_a = 0
	set decimal_b = 0
	foreach index (`seq 1 4`)
		set power = `echo "256^( 4 - $index )" | bc`
		@ decimal_a = ( $decimal_a + ( ${address_a[$index]} * $power))
		@ decimal_b = ( $decimal_b + ( ${address_b[$index]} * $power))
	end
	@ number_of_adresses_to_ping = ( $decimal_b - $decimal_a + 1 )

# Transform current adress to string
TRANSFORM_ADDRESS_TO_STRING:
	foreach segment ($current_address)
		if ( "$address_string" == "" ) then
			set address_string = "$address_string$segment"
		else
			set address_string = "$address_string.$segment"
		endif
	end

# Ping adress
PING:
	if ( $number_of_adresses_to_ping > 0 ) then
		ping -c 1 $address_string > /dev/null
		if ( $? == 0 ) then
			echo "$address_string is alive"
		else
			echo "$address_string is dead"
		endif
		foreach index (`seq 4 1`)
			if ( ${current_address[$index]} < 255 ) then
				@ current_address[$index] = ($current_address[$index] + 1)
				break
			else
				@ current_address[$index] = 0
			endif
		end
		set address_string = ""
		set number_of_adresses_to_ping = ($number_of_adresses_to_ping - 1)
		goto TRANSFORM_ADDRESS_TO_STRING
	endif
