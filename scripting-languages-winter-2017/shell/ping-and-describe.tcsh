#!/usr/bin/env tcsh
# Witold Bobrowski ; Group 2
#
# Ping all addresses in given range

# CONSTANTS

# VARIABLES (with default values)

set address_a = (0 0 0 0)
set address_b = (0 0 0 0)
set current_address = (0 0 0 0)
set address_string = ""
set number_of_adresses_to_ping = 0
set ports_to_ping=()

# Main program

# Transform two strings to arrays
TRANSFROM_AND_COMPARE_ADDRESSES:
	set temp_a = ($1:as/./ /)
	set temp_b = ($2:as/./ /)
    set address_a = ($temp_a:q)
    set address_b = ($temp_b:q)
	foreach index (`seq 1 4`)
		if ( ${temp_a[$index]} < ${temp_b[$index]} ) then
			set address_a = ($temp_a:q); set address_b = ($temp_b:q); break
		elif ( ${temp_a[$index]} > ${temp_b[$index]} ) then
			set address_a = ($temp_b:q); set address_b = ($temp_a:q); break
		endif
	end
	set current_address = ($address_a)

# Transform string of ports to array of ports
EVALUATE_PORTS:
	set ports_to_ping = ($3:as/,/ /)

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

# Pinging flow control
PING_COORDINATION:
	if ( $number_of_adresses_to_ping < 1 ) then
        exit
	endif

# Ping adress
PING:
    echo "Pinging $address_string ..."
    ping -c 1 $address_string > /dev/null
    if ( $? == 0 ) then
        echo "$address_string is alive"
        goto PING_PORTS
    else
        echo "$address_string is dead"
        goto GET_NEXT_ADDRESS
    endif

# Ping each port and try to get description
PING_PORTS:
	foreach port ($ports_to_ping)
        set output = ""
        nc -v -n -z -G 2 -w 1 $address_string $port >& /dev/null
        if ( $? == 0 ) then
            set result = ""
            if ( $port == 21 ) then
                set result = `echo -e "QUIT" | nc $address_string $port | grep -oe '220.*'`
            else if ( $port == 22 ) then
                set result = `echo -e "\n" | nc $address_string $port | grep -oe 'SSH.*'`
            else if ( $port == 25 ) then
                set result = `echo -e "QUIT" | nc $address_string $port | grep -oe '220.*'`
            else if ( $port == 80 || $port == 443 ) then
                set result = `echo -e "GET / HTTP/1.1\r\n\r\n" | nc $address_string $port | grep -oe 'Server: .*'`
            endif
            if ( "$result" == "" ) then
                set output = "Port $port is open"
            else
                set output = "Port $port $result"
            endif
    	else
            set output = "Port $port is closed"
    	endif
    	echo "|- "$output
    end
    echo ""

# Increment current address
GET_NEXT_ADDRESS:
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
