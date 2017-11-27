#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print words from line with custom split string

use strict;
use warnings;

# VARIABLES

my $first        = 0;
my $second       = 0;
my $split_string = " ";

# SUBROUTINES

sub print_error_and_exit {
    print STDERR
"Usage: perl print-file-words-range.pl [split string] [first] [second] [file name] [...]\n";
    exit;
}

sub is_numeric_and_positive {
    return ( $_[0] =~ /[0-9]+$/ ) && ( $_[0] !~ /^[-]/ );
}

sub print_file {
    open( my $data, '<:encoding(UTF-8)', $_[0] )
      or die "Could not open file '$_[0]' $!";
    my $number = 0;
    while ( my $line = <$data> ) {
        ++$number;
        my @words = split( "$split_string", $line );
        chomp $line;
        if ( $first <= $#words && $second <= $#words ) {
            foreach my $word ( $first, $second ) {
                print "$words[$word] ";
            }
            print "\n";
        }
        else {
            print STDERR "Line $number out of range in file: $_[0]\n";
        }
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

$first  = $ARGV[1];
$second = $ARGV[2];

foreach my $argument ( 3 .. $#ARGV ) {
    print_file( $ARGV[$argument] );
}
