#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Listen on specific port and count logs

# CONSTANTS

SERVER_MODE="server"
CLIENT_MODE="client"
PORT="port"
COUNT="count"
RC_FILE_PATH="rc_path"
ADDRESS="address"

declare -A DEFAULTS=( [$PORT]="8080" [$COUNT]="1" [$RC_FILE_PATH]="${HOME}/.countrc" [$ADDRESS]="127.0.0.1")

# VARIABLES

mode=""
port=""
rc_file_path=""
address=""
count=0

# FUNCTIONS

display_help() {
    echo "counting-server.bash -- Listen on specific port and count logs."
    echo
    echo "Usage: ./counting-server.bash [--help] [--server | --client] [--port=port] [--ipaddress=address] [--rcfile=file]"
    echo
    echo "Options:"
    echo "	-h | --help 	    Show help"
    echo "	-p | --port       	port to listen to"
    echo "	-i | --ipaddress 	ip address to listen to"
    echo "	-f | --rcfile 	    path to rc file"
    echo "	-c | --client     	run as client"
    echo "	-s | --server    	run as server"
    exit
}

evaluate_script_name() {
    if [[ ${0##*/} == "server.sh" ]]; then
        mode=$SERVER_MODE
    elif [[ ${0##*/} == "client.sh" ]]; then
        mode=$CLIENT_MODE
    fi
}

evaluate_arguments() {
    local looks_like_integer='^[0-9]+$'
    local expects_port=false
    local expects_address=false
    local expects_rcfile=false
    for argument in $@; do
        case "$argument" in
            -h|--help) display_help ;;
            -c|--client) mode=$CLIENT_MODE ;;
            -s|--server) mode=$SERVER_MODE ;;
            -p|--port) check_expecting_options; expects_port=true ;;
            -i|--ipaddress) check_expecting_options; expects_address=true ;;
            -f|--rcfile) check_expecting_options; expects_rcfile=true ;;
            *)
                if [[ $expects_port == true ]] && [[ "$argument" =~ $looks_like_integer ]]; then
                    port="$argument"
                    expects_port=false
                fi
                if [[ $expects_address == true ]] && [[ "$argument" =~ $looks_like_integer ]]; then
                    address="$argument"
                    expects_address=false
                fi
                if [[ $expects_rcfile == true ]]; then
                    rc_file_path="$argument"
                    expects_rcfile=false
                fi
                shift ;;
        esac
    done
    check_expecting_options
}

check_expecting_options() {
    if [[ $expects_port == true ]] || [[ $expects_address == true ]] || [[ $expects_rcfile == true ]]; then
        echo "[!] Wrong usage." >&2
        display_help
        exit
    fi
}

evaluate_defined_properties() {
    if [[ -z $mode ]]; then
        echo "[!] Please define mode."
    fi
    if [[ -z $rc_file_path ]]; then
        rc_file_path=${DEFAULTS["$RC_FILE_PATH"]}
    fi
    if [[ -z $address ]]; then
        address=${DEFAULTS["$ADDRESS"]}
    fi
    if [[ -z $port ]]; then
        port=$(get_from_rc_file $PORT)
    fi
}

get_from_rc_file() {
    create_rc_file_if_needed $1 ${DEFAULTS["$1"]}
    line=$(grep -e "^$1"=".*" $rc_file_path | grep -o "[0-9.]\+")
    if [[ -z $line ]]; then
        write_to_rc_file $1 ${DEFAULTS["$1"]}
        echo ${DEFAULTS["$1"]}
    else
        echo $line
    fi
}

write_to_rc_file() {
    create_rc_file_if_needed $1 $2
    line="$(cat $rc_file_path | grep -n "^$1" | cut -d : -f 1 | tail -1)"
    if [[ -z $line ]]; then
        echo $1"="$2 >> $rc_file_path
    else
        sed -e "$line s/.*/$1=$2/" -i "" $rc_file_path
    fi
}

create_rc_file_if_needed() {
    if ! [[ -f $rc_file_path ]]; then
        echo $1=$2 > $rc_file_path
    fi
}

listen() {
    if nc -v -n -z -G 2 -w 1 $address $port &> /dev/null; then
        echo "[!] There is a server running at $address:$port. Try different port." >&2
        exit
    fi
    count=$(get_from_rc_file $COUNT)
    while nc -l $address $port; do
        count=$(( $count + 1 ))
        echo "Count: "$count
        write_to_rc_file $COUNT $count
    done
}

connect() {
    if echo "Hello!" | nc -v -n -w 1 $address $port &> /dev/null; then
        echo $address:$port "ID = "$(get_from_rc_file $COUNT)
    else
        echo "[!] Connection to $address:$port failed. The server is not running." >&2
        exit
    fi
}

# Main program
evaluate_script_name $0
evaluate_arguments $@
evaluate_defined_properties

case "$mode" in
    $SERVER_MODE) listen $port ;;
    $CLIENT_MODE) connect $port ;;
esac
