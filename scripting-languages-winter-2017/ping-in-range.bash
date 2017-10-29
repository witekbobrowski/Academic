#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Ping all adresses in given range

# VARIABLES (with default values)

address_a=(0 0 0 0)
address_b=(0 0 0 0)
current_address=(0 0 0 0)
address_string=""
number_of_adresses_to_ping=0

# FUNCTIONS

# Transform current adress to string
# Arguments:
#   NONE
transform_address_to_string() {
	for segment in "${current_address[@]}"; do
		[ -z "$address_string" ] && address_string+=$segment || address_string+="."$segment
	done
}

# Transform two give adresses from string
# Arguments:
#   1) first address
#   2) second address
transform_and_compare_addresses() {
	local temp_a=(0 0 0 0)
	local temp_b=(0 0 0 0)
	IFS='.' read -r -a temp_a <<< "$1"
	IFS='.' read -r -a temp_b <<< "$2"
	for index in "${!temp_a[@]}"
	do
		if (( ${temp_a[index]} < ${temp_b[index]} )); then
			address_a=("${temp_a[@]}") ; address_b=("${temp_b[@]}")  ; break
		elif (( ${temp_a[index]} > ${temp_b[index]} )); then
			address_a=("${temp_b[@]}")  ; address_b=("${temp_a[@]}")  ; break
		fi
	done
}

# Calculate how many adresses should be pinged
# Arguments:
#   NONE
calculate_number_of_adresses_to_ping() {
	local decimal_a=0
	local decimal_b=0
	for index in {0..3}; do
		decimal_a=$(($decimal_a + $((${address_a[index]} * $((256 ** $((3 - $index))))))))
		decimal_b=$(($decimal_b + $((${address_b[index]} * $((256 ** $((3 - $index))))))))
	done
	number_of_adresses_to_ping=$(($decimal_b - $decimal_a + 1))
}

# Ping adresses in range
# Arguments:
#   NONE
ping_in_range() {
	current_address=("${address_a[@]}")
	while (( $number_of_adresses_to_ping > 0 )); do
		transform_address_to_string
		ping -c 1 $address_string &> /dev/null && echo "$address_string is alive" || echo "$address_string is dead"
		for index in {3..0}; do
			if (( ${current_address[index]} < 255 )); then
				((++current_address[$index]))
				break
			else
				((current_address[$index]=0))
			fi
		done
		address_string=""
		((--number_of_adresses_to_ping))
	done
}

transform_and_compare_addresses $1 $2
calculate_number_of_adresses_to_ping
ping_in_range
