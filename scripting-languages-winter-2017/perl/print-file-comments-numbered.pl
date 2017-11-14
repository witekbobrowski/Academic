#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print file line-by-line excluding comments (#) with lines numbered

use strict;
use warnings;

sub print_file {
    open(my $data, '<:encoding(UTF-8)', $_[0])
        or die "Could not open file '$_[0]' $!";
    while (my $line = <$data>) {
        chomp $line;
        print "$.. $line\n";
    }
}

foreach (@ARGV) {
    print_file $_;
}
