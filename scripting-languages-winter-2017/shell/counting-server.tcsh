#!/usr/bin/env tcsh
# Witold Bobrowski ; Group 2
#
# Listen on specific port and count logs

# CONSTANTS

# possible modes
set SERVER_MODE = "server"
set CLIENT_MODE = "client"

# String for keys
set PORT = "port"
set COUNT = "count"
set RC_FILE_PATH = "rc_path"
set ADDRESS = "address"

# DEFAULTS
set PORT_DEFAULT = "8080"
set COUNT_DEFAULT = "0"
set RC_FILE_PATH_DEFAULT = "${HOME}/.countrc"
set ADDRESS_DEFAULT = "127.0.0.1"

# VARIABLES

set mode = $CLIENT_MODE
set port = $PORT_DEFAULT
set rc_file_path = $RC_FILE_PATH_DEFAULT
set address = $ADDRESS_DEFAULT

# ALIASES

alias create_rc_file_if_needed 'if !( -f $rc_file_path ) echo \!:3\!:1=\!:2 > $rc_file_path;'
alias get_line_number_from_rc_file 'cat $rc_file_path | grep -n \!:1 | cut -d : -f 1 | tail -1'
alias get_line_from_rc_file 'grep -e \!:1 $rc_file_path'
alias write_to_rc_file 'create_rc_file_if_needed \!:1 \!:2 \!:3 ; if ( `get_line_number_from_rc_file "\!:3\!:1"` == "" ) echo "\!:3\!:1=\!:2" >> $rc_file_path ; if ( `get_line_number_from_rc_file "\!:3\!:1"` != "" ) sed -e "`get_line_number_from_rc_file "\!:3\!:1"` s/.*/\!:3\!:1=\!:2/" -i "" $rc_file_path'
alias get_from_rc_file 'if ( `get_line_from_rc_file "\!:2\!:1="` == "" ) echo ""; if ( `get_line_from_rc_file "\!:2\!:1="` != "" ) echo `get_line_from_rc_file "\!:2\!:1=" | cut -d = -f 2`'

# Main program

MAIN:
    switch ( $mode )
        case $SERVER_MODE:
            goto LISTEN
            breaksw
        case $CLIENT_MODE:
            goto CONNECT
            breaksw
        default:
            goto HELP
    endsw
    exit

HELP:
    echo "counting-server.tcsh -- Listen on specific port and count logs."
    echo
    echo "Usage: ./counting-server.tcsh [--help] [--server | --client] [--port=port] [--ipaddress=address] [--rcfile=file]"
    echo
    echo "Options:"
    echo "	-h | --help 	    Show help"
    echo "	-p | --port       	port to listen to"
    echo "	-i | --ipaddress 	ip address to listen to"
    echo "	-f | --rcfile 	    path to rc file"
    echo "	-c | --client     	run as client"
    echo "	-s | --server    	run as server"
    exit

LISTEN:
    nc -v -n -z -G 2 -w 1 $address $port >& /dev/null
    if ( $? == 0 ) then
        echo "[\!] There is a server running at "$address":"$port". Try different port."
        exit
    endif
    @ count = `get_from_rc_file $COUNT $address":"$port"\ "`
    if ( $count == "" ) then
        @ count = 0
        write_to_rc_file $COUNT $count $address":"$port"\ "
    else
    echo "Listening to "$address":"$port".  Current count = $count"
    while ( 1 )
        nc -l $address $port
        @ count = ( $count + 1 )
        write_to_rc_file $COUNT $count $address":"$port"\ "
        echo "Count: $count"
    end

CONNECT:
    echo "Hello! tcsh client here" | nc -v -n -w 1 $address $port >& /dev/null
    if ( $? == 0 ) then
        echo $address":"$port" ID = "`get_from_rc_file $COUNT $address":"$port"\ "`
    else
        echo "[\!] Connection to "$address":"$port" failed. The server is not running."
    endif
    exit
