#!/usr/bin/env bash
# Witold Bobrowski ; Group 2
#
# Print calssic multiplication table

# FUNCTIONS

# reduce: Take two parameters and concatenate arg1 with arg2 depending on arg2 value

# Accumulate buffer with new value and proper spacing
# Arguments:
#   1) A number that should be added to the buffer
reduce() {
  (( $1 < 10 )) && buffer+="  "$1 || buffer+=" "$1
}

# Print multiplication table
# Arguments:
#   NONE
print_multiplication_table() {
  echo "* __1__2__3__4__5__6__7__8__9  "
  for a in {1..9}; do
    buffer=$a"|"
    for b in {1..9}; do
      reduce $(( $a * $b ))
    done
    echo "$buffer"
  done
}

# Main program

print_multiplication_table
