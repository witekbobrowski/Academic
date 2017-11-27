#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print words from line

use strict;
use warnings;

# VARIABLES

my $first  = 0;
my $second = 0;

# SUBROUTINES

sub print_error_and_exit {
    print STDERR "Usage: perl print-file-words-range.pl [lower bound] [upper bound] [file name] [...]\n";
    exit;
}

sub is_numeric_and_positive {
    return ( $_[0] =~ /[0-9]+$/ ) && ( $_[0] !~ /^[-]/ );
}

sub print_file {
    open( my $data, '<:encoding(UTF-8)', $_[0] )
      or die "Could not open file '$_[0]' $!";
    while ( my $line = <$data> ) {
        my @words = split( " ", $line );
        chomp $line;
        if ( $first < $#words && $second < $#words ) {
            foreach my $word ($first, $second) {
                print "$words[$word] ";
            }
        }
        print "\n";
    }
}

# Main program

if ( $#ARGV < 2 ) {
    print_error_and_exit;
}

foreach my $argument ( 0 .. 1 ) {
    if ( !is_numeric_and_positive( $ARGV[$argument] ) ) {
        print_error_and_exit;
    }
}

$first = $ARGV[0];
$second = $ARGV[1];

foreach my $argument ( 2 .. $#ARGV ) {
    print_file( $ARGV[$argument] );
}
