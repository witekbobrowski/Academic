#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Ping all adresses in given range

# VARIABLES (with default values)

address_a=(0 0 0 0)
address_b=(0 0 0 0)
current_address=(0 0 0 0)
address_string=""

# FUNCTIONS

transform_address_to_string() {
	for segment in "${current_address[@]}"; do
		[ -z "$address_string" ] && address_string+=$segment || address_string+="."$segment
	done
}

transform_string_to_addresses() {
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

ping_to_address() {
	current_address=("${address_a[@]}")
	for index in "3" "2" "1" "0"; do
		while (( ${current_address[index]} < 255 )); do
			transform_address_to_string
			ping -c 1 "$address_string" > /dev/null
    	if [ $? -eq 0 ]; then
    		echo "node $address_string is up"
    	else
    		echo "node $address_string is down"
    	fi
			((++current_address[index]))
			address_string=""
		done
	done
}

transform_string_to_addresses $1 $2
ping_to_address
