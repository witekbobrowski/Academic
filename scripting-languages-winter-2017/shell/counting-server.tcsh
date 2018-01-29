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

set mode = ""
set port = ""
set rc_file_path = ""
set address = ""

# ALIASES

alias get_line_number_from_rc_file 'cat $rc_file_path | grep -n \!:1 | cut -d : -f 1 | tail -1'
alias get_line_from_rc_file 'grep -e \!:1 $rc_file_path'
alias write_to_rc_file 'if ( `get_line_number_from_rc_file "\!:3\!:1"` == "" ) echo "\!:3\!:1=\!:2" >>! $rc_file_path ; if ( `get_line_number_from_rc_file "\!:3\!:1"` != "" ) sed -e "`get_line_number_from_rc_file "\!:3\!:1"` s/.*/\!:3\!:1=\!:2/" -i "" $rc_file_path'
alias get_from_rc_file 'if ( `get_line_from_rc_file "\!:2\!:1="` == "" ) echo ""; if ( `get_line_from_rc_file "\!:2\!:1="` != "" ) echo `get_line_from_rc_file "\!:2\!:1=" | cut -d = -f 2`'
alias check_expecting_options 'if ( $expects_port || $expects_address || $expects_rcfile ) goto HELP'
# Main program

EVALUATE_ARGUMENTS:
    set expects_port = 0
    set expects_address = 0
    set expects_rcfile = 0
    foreach argument ($argv)
        switch ($argument)
            case "-h":
            case "--help":
                check_expecting_options
                goto HELP
                breaksw
            case "-c":
            case "--client":
                check_expecting_options
                set mode = $CLIENT_MODE
                breaksw
            case "-s":
            case "--server":
                check_expecting_options
                set mode = $SERVER_MODE
                breaksw
            case "-p":
            case "--port":
                check_expecting_options
                set expects_port = 1
                breaksw
            case "-i":
            case "--ipaddress":
                check_expecting_options
                set expects_address = 1
                breaksw
            case "-f":
            case "--rcfile":
                check_expecting_options
                set expects_rcfile = 1
                breaksw
            case *:
                if ( $expects_port && `echo $argument | egrep -e '^[0-9]+$'` ) then
                    set port = "$argument"
                    set expects_port = 0
                endif
                if ( $expects_address && `echo $argument | egrep -e '^[0-9]+$'` ) then
                    set address = "$argument"
                    set expects_address = 0
                endif
                if ( $expects_rcfile ) then
                    set rc_file_path = "$argument"
                    set expects_rcfile = 0
                endif
                breaksw
        endsw
    end
    check_expecting_options

EVALUATE_SCRIPT_NAME:
    if (  `basename $0` == "server.sh" ) then
        set mode = $SERVER_MODE
    else if ( `basename $0` == "client.sh" ) then
        set mode = $CLIENT_MODE
    endif

EVALUATE_PROPERTIES:
    if ( $mode == "" ) then
        echo "[!] Please define mode."
        goto HELP
    endif
    if ( $rc_file_path == "" ) then
        set rc_file_path = $RC_FILE_PATH_DEFAULT
    endif
    if ( $address == "" ) then
        set address = `get_from_rc_file $ADDRESS ""`
        if ( $address == "" ) then
            set address = $ADDRESS_DEFAULT
            write_to_rc_file $ADDRESS $address ""
        endif
    endif
    if ( $port == "" ) then
        set port = `get_from_rc_file $PORT ""`
        if ( $port == "" ) then
            set port = $PORT_DEFAULT
            write_to_rc_file $PORT $port ""
        endif
    endif

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
