package Utils;

use strict;
use warnings;

# SUBROUTINES

# Check if string looks like integer
sub looks_like_integer {
	return "$_[0]" =~ /^[+-]?\d+$/;
}

# Check if string looks like natural number
sub looks_like_natural_number {
	return "$_[0]" =~ /^\d+$/;
}

# Check if string looks like decimal number
sub looks_like_decimal_number {
	return "$_[0]" =~ /^-?\d+\.?\d*$/;
}

# Check if string looks like number
sub looks_like_number {
	return "$_[0]" =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/;
}

# regexp's from https://docstore.mik.ua/orelly/perl4/cook/ch02_02.htm

# backward compatibility
1;
