#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print words in range with custom split string

use strict;
use warnings;

# VARIABLES

my $left_bound   = 0;
my $right_bound  = 0;
my @range        = ();
my $split_string = " ";

# SUBROUTINES

sub print_error_and_exit {
    print STDERR
"Usage: perl print-file-words-range.pl [split string] [lower bound] [upper bound] [file name] [...]\n";
    exit;
}

sub is_numeric_and_positive {
    return ( $_[0] =~ /[0-9]+$/ ) && ( $_[0] !~ /^[-]/ );
}

sub get_range {
    $left_bound  = $_[0];
    $right_bound = $_[1];
    if ( $left_bound < $right_bound ) {
        return ( $left_bound .. $right_bound );
    }
    else {
        return ( $right_bound .. $left_bound );
    }
}

sub range_is_valid {
    return ( $left_bound <= $_[0] && $right_bound <= $_[0] );
}

sub print_file {
    open( my $data, '<:encoding(UTF-8)', $_[0] )
      or die "Could not open file '$_[0]' $!";
    while ( my $line = <$data> ) {
        my @words = split( "$split_string", $line );
        chomp $line;
        if ( range_is_valid($#words) ) {
            foreach my $word (@range) {
                print "$words[$word] ";
            }
        }
        print "\n";
    }
}

# Main program

if ( $#ARGV < 3 ) {
    print_error_and_exit;
}

$split_string = "$ARGV[0]";

foreach my $argument ( 1 .. 2 ) {
    if ( !is_numeric_and_positive( $ARGV[$argument] ) ) {
        print_error_and_exit;
    }
}

@range = get_range( $ARGV[1], $ARGV[2] );

foreach my $argument ( 3 .. $#ARGV ) {
    print_file( $ARGV[$argument] );
}
