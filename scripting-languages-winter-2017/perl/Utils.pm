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

# Get grade from string
sub get_grade {
    my $possible_grade = "$_[0]";
    my $floating_point = 0;
    my $number         = 0;
    if ( "$possible_grade" =~ /^\d*(\.\d*)?$/ ) {
        $number = $possible_grade;
    }
    elsif ( "$possible_grade" =~ /^\d[-]?$/ ) {
        $floating_point = -0.25;
        chop($possible_grade);
        $number = $possible_grade;
    }
    elsif ( "$possible_grade" =~ /^[-]?\d$/ ) {
        $floating_point = -0.25;
        $number = substr( "$possible_grade", 1 );
    }
    elsif ( "$possible_grade" =~ /^\d[+]?$/ ) {
        $floating_point = +0.25;
        chop($possible_grade);
        $number = $possible_grade;
    }
    elsif ( "$possible_grade" =~ /^[+]?\d$/ ) {
        $floating_point = +0.25;
        $number = substr( "$possible_grade", 1 );
    }
    return ( 2 <= $number + $floating_point && $number + $floating_point <= 5 )
      ? $number + $floating_point
      : 0;
}

# regexp's from https://docstore.mik.ua/orelly/perl4/cook/ch02_02.htm

# backward compatibility
1;
