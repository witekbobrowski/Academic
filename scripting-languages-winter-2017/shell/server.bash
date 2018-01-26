#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Listen on specific port and count logs

# CONSTANTS

SERVER_MODE="server"
CLIENT_MODE="client"
DEFAULT_PORT=8080
LOCALHOST="127.0.0.1"

# VARIABLES

mode=""
port=""
count=0

# FUNCTIONS

display_help() {
    echo "whoami.tcsh -- print current user"
    echo
    echo "Usage: ./server.bash [--help] [-h] [--server] [-s] [--client] [-c] [--port] [-p] port"
    echo
    echo "Options:"
    echo "	-h | --help 	Show help"
    echo "	-p | --port 	port to listen to"
    echo "	-c | --client 	run as client"
    echo "	-s | --server 	run as server"
    exit
}

evaluate_arguments() {
    local is_numerical='^[0-9]+$'
    local expects_port=false
    for argument in $@; do
        case "$argument" in
            -h|--help)
                display_help ;;
            -c|--client)
                mode=CLIENT_MODE
                shift ;;
            -s|--server)
                mode=SERVER_MODE
                shift ;;
            -p|--port)
                expects_port=true
                shift ;;
            *)
                if [[ $expects_port == true ]] && [[ "$argument" =~ $is_numerical ]]; then
                    port="$argument"
                fi
                shift ;;
        esac
    done
    if [[ -z $mode ]]; then
        echo "Please define mode"
    fi
    if [[ -z $port ]]; then
        echo "ERROR: port is not defined."
        display_help
    fi
}

evaluate_arguments $@
