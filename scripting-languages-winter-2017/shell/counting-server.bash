#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Listen on specific port and count logs

# CONSTANTS

# possible modes
SERVER_MODE="server"
CLIENT_MODE="client"

# String for keys
PORT="port"
COUNT="count"
RC_FILE_PATH="rc_path"
ADDRESS="address"

# Associative array of defaults
declare -A DEFAULTS=( [$PORT]="8080" [$COUNT]="0" [$RC_FILE_PATH]="${HOME}/.countrc" [$ADDRESS]="127.0.0.1")

# VARIABLES

mode=""
port=""
rc_file_path=""
address=""

# FUNCTIONS

# Print script usage instructions
# Arguments:
#   NONE
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

# Check if script was called using symbolic link, and set mode accordingly
# Arguments:
#   1) string describing the name under which this script was called
evaluate_script_name() {
    if [[ ${0##*/} == "server.sh" ]]; then
        mode=$SERVER_MODE
    elif [[ ${0##*/} == "client.sh" ]]; then
        mode=$CLIENT_MODE
    fi
}

# Go throught each argument and evaluate options
# Arguments:
#   *) Array of arguments passed to the script
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

# Check if any option was declared to be passed. Print to stderr and exit if true
# Arguments:
#   NONE
check_expecting_options() {
    if [[ $expects_port == true ]] || [[ $expects_address == true ]] || [[ $expects_rcfile == true ]]; then
        echo "[!] Wrong usage." >&2
        display_help
        exit
    fi
}

# Check which variables are not set, if true take appropriate action (ex. set default value)
# Arguments:
#  NONE
evaluate_defined_properties() {
    if [[ -z $mode ]]; then
        echo "[!] Please define mode."
    fi
    if [[ -z $rc_file_path ]]; then
        rc_file_path=${DEFAULTS["$RC_FILE_PATH"]}
    fi
    if [[ -z $address ]]; then
        address=$(get_from_rc_file $ADDRESS)
    fi
    if [[ -z $port ]]; then
        port=$(get_from_rc_file $PORT)
    fi
}

# Try to find rc file at given path, if missing create it by appendin passed arguments
# Arguments:
#   1) key string under which value in next string will be saved
#   2) value for key
#   3) prefix that will be inserted before key for extra context
create_rc_file_if_needed() {
    if ! [[ -f $rc_file_path ]]; then
        echo $3$1=$2 > $rc_file_path
    fi
}

# Append passed arguments to rc file to new or existing line
# Arguments:
#   1) key string under which value in next string will be saved
#   2) value for key
#   3) prefix that will be inserted before key for extra context
write_to_rc_file() {
    create_rc_file_if_needed $1 $2 $3
    line="$(cat $rc_file_path | grep -n "$3$1" | cut -d : -f 1 | tail -1)"
    if [[ -z $line ]]; then
        echo "$3$1=$2" >> $rc_file_path
    else
        sed -e "$line s/.*/$3$1=$2/" -i "" $rc_file_path
    fi
}

# Return value from rc file for given key (with optional prefix)
# Arguments:
#  1) key string under which value is stored
#  2) prefix that will be inserted before key for extra context
get_from_rc_file() {
    create_rc_file_if_needed $1 ${DEFAULTS["$1"]}
    prefix="$2$1="
    line=$(grep -e "$prefix" $rc_file_path)
    if [[ -z $line ]]; then
        write_to_rc_file $1 ${DEFAULTS["$1"]} "$2"
        echo ${DEFAULTS["$1"]}
    else
        echo "${line#$prefix}"
    fi
}

# Listen and count visitors on passed ip_address:port
# Arguments:
#   1) string representing the address
#   2) string representing the port
listen() {
    if nc -v -n -z -G 2 -w 1 $1 $2 &> /dev/null; then
        echo "[!] There is a server running at $1:$2. Try different port." >&2
        exit
    fi
    count=$(get_from_rc_file $COUNT "$1:$2 ")
    echo "Listening to $1:$2.  Current count = $count"
    while nc -l $1 $2; do
        write_to_rc_file $COUNT $(( $(get_from_rc_file $COUNT "$1:$2 ") + 1 )) "$1:$2 "
        echo "Count: "$(get_from_rc_file $COUNT "$1:$2 ")
    done
}

# Call port on some address to say hello
# Arguments:
#   1) string representing the address
#   2) string representing the port
connect() {
    if echo "Hello! bash client here" | nc -v -n -w 1 $1 $2 &> /dev/null; then
        echo $1:$2 "ID = "$(get_from_rc_file $COUNT "$1:$2 ")
    else
        echo "[!] Connection to $1:$2 failed. The server is not running." >&2
        exit
    fi
}

# Main program
evaluate_script_name $0
evaluate_arguments $@
evaluate_defined_properties

case "$mode" in
    $SERVER_MODE) listen $address $port ;;
    $CLIENT_MODE) connect $address $port ;;
esac
