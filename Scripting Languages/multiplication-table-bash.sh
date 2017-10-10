#!/usr/bin/env bash
# Witold Bobrowski ; Group 2

# FUNCTIONS

# reduce: Take two parameters and concatenate arg1 with arg2 depending on arg2 value
reduce() {
  (( $1 < 10 )) && buffer="$buffer  $1" || buffer="$buffer $1"
}

# print_multiplication_table: iterate over 1-9 digits and using 'reduce' accumulate output in 'buffer'
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

print_multiplication_table
