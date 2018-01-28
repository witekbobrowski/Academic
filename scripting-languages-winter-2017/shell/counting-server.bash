#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Listen on specific port and count logs

# CONSTANTS

SERVER_MODE="server"
CLIENT_MODE="client"
PORT_STR="port"
COUNT_STR="count"
LOCALHOST="127.0.0.1"
RC_FILE_PATH="${HOME}/.countrc"

# CONSTANTS

declare -A DEFAULTS=( [$PORT_STR]="8080" [$COUNT_STR]="0" )

# VARIABLES

mode=""
port=""
count=0

# FUNCTIONS

display_help() {
    echo "counting-server.bash -- Listen on specific port and count logs."
    echo
    echo "Usage: ./counting-server.bash [--help] [--server | --client] [--port=port]"
    echo
    echo "Options:"
    echo "	-h | --help 	Show help"
    echo "	-p | --port 	port to listen to"
    echo "	-c | --client 	run as client"
    echo "	-s | --server 	run as server"
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
    for argument in $@; do
        case "$argument" in
            -h|--help)
                display_help ;;
            -c|--client)
                mode=$CLIENT_MODE
                shift ;;
            -s|--server)
                mode=$SERVER_MODE
                shift ;;
            -p|--port)
                expects_port=true
                shift ;;
            *)
                if [[ $expects_port == true ]] && [[ "$argument" =~ $looks_like_integer ]]; then
                    port="$argument"
                fi
                shift ;;
        esac
    done
}

evaluate_defined_properties() {
    if [[ -z $mode ]]; then
        echo "[!] Please define mode."
    fi
    if [[ -z $port ]]; then
        port=$(get_from_rc_file $PORT_STR)
    fi
}

get_from_rc_file() {
    line=$(grep -e "^$1"=".*" $RC_FILE_PATH | grep -o "[0-9.]\+")
    if [[ -z $line ]]; then
        write_to_rc_file $1 ${DEFAULTS["$1"]}
        echo ${DEFAULTS["$1"]}
    else
        echo $line
    fi
}

write_to_rc_file() {
    line="$(cat $RC_FILE_PATH | grep -n "^$1" | cut -d : -f 1 | tail -1)"
    if [[ -z $line ]]; then
        echo $1"="$2 >> $RC_FILE_PATH
    else
        sed -e "$line s/.*/$1=$2/" -i "" $RC_FILE_PATH
    fi
}

listen() {
    if nc -v -n -z -G 2 -w 1 $LOCALHOST $port &> /dev/null; then
        echo "[!] There is a server running at $LOCALHOST:$port. Try different port." >&2
        exit
    fi
    count=$(get_from_rc_file $COUNT_STR)
    while nc -l $LOCALHOST $port; do
        count=$(( $count + 1 ))
        echo $count
        write_to_rc_file $COUNT_STR $count
    done
}

connect() {
    if echo "Hello!" | nc -v -n -w 1 $LOCALHOST $port &> /dev/null; then
        echo $LOCALHOST:$port "Count = "$(get_from_rc_file $COUNT_STR)
    else
        echo "[!] Connection to $LOCALHOST:$port failed. The server is not running." >&2
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
