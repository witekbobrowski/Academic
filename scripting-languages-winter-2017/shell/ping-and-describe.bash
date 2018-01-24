#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Ping all addresses in given range

# CONSTANTS

declare -A PORTS=( [21]="FTP" [22]="SSH" [25]="SMTP" [80]="HTTP" [443]="HTTPS" )

# VARIABLES (with default values)

address_a=(0 0 0 0)
address_b=(0 0 0 0)
current_address=(0 0 0 0)
address_string=""
number_of_adresses_to_ping=0
ports_to_ping=()

# FUNCTIONS

# Transform current adress to string
# Arguments:
#   NONE
transform_address_to_string() {
	for segment in "${current_address[@]}"; do
		[ -z "$address_string" ] && address_string+=$segment || address_string+="."$segment
	done
}

# Evaluate ports from sting and put them in the ports_to_ping array
# Arguments:
#   1) string of port separated with ','
gather_ports_to_ping() {
	IFS=',' read -r -a ports_to_ping <<< "$1"
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
	address_a=("${temp_a[@]}") ; address_b=("${temp_b[@]}")
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

# Increment current_address
# Arguments:
#   NONE
get_next_address() {
	for index in {3..0}; do
		if (( ${current_address[index]} < 255 )); then
			((++current_address[$index]))
			break
		else
			((current_address[$index]=0))
		fi
	done
}

# Ping given port on specified address and print description
# Arguments:
#   1) string representing the address
#   2) string representing the port
ping_port_at_address() {
    local output=""
    if nc -v -n -z -G 2 -w 1 $1 $2 &> /dev/null; then
		local result=""
		local protocol=${PORTS["$2"]}
		if [ $protocol == "FTP" ]; then
			result=$(echo -e "QUIT" | nc $1 $2 | grep -oe '220.*')
		elif [[ $protocol == "SSH" ]]; then
			result=$(echo -e "\n" | nc $1 $2 | grep -oe 'SSH.*')
		elif [[ $protocol == "SMPT" ]]; then
			result=$(echo -e "QUIT" | nc $1 $2 | grep -oe '220.*')
		elif [[ $protocol == "HTTP" ]] || [[ $protocol == "HTTPS" ]]; then
			result=$(echo -e "GET / HTTP/1.1\r\n\r\n" | nc $1 $2 | grep -oe 'Server: .*')
		fi
		if [[ -z $result ]]; then
		 	output="Port "$2" is open"
		else
			output="Port $2 "$result
		fi
	else
		output="Port $2 is closed"
	fi
	echo "|- "$output
}

# Ping address
# Arguments:
#   1) string representing the address
#   2) array of ports to ping if address is alive
ping_address() {
  declare -a ports=("${!2}")
	echo "Pinging $1 ..."
	if ping -c 1 $1 &> /dev/null; then
		echo "$1 is alive"
		for port in "${ports[@]}"; do
			ping_port_at_address $1 $port
		done
		echo ""
	else
		echo "$1 is dead"
	fi
}


# Ping adresses in range
# Arguments:
#   NONE
ping_in_range() {
	current_address=("${address_a[@]}")
	while (( $number_of_adresses_to_ping > 0 )); do
		transform_address_to_string
		ping_address $address_string ports_to_ping[@]
		get_next_address
		address_string=""
		((--number_of_adresses_to_ping))
	done
}

transform_and_compare_addresses $1 $2
gather_ports_to_ping $3
calculate_number_of_adresses_to_ping
ping_in_range
