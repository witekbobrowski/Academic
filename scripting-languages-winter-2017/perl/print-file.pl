#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print file line-by-line

use strict;
use warnings;
use Getopt::Long;

my $should_hide_comments = 0;
my $should_number_lines = 0;
my $should_number_lines_for_every_file_separately = 0;

sub print_file {
    open(my $data, '<:encoding(UTF-8)', $_[0])
        or die "Could not open file '$_[0]' $!";
    while (my $line = <$data>) {
        if ( $should_hide_comments && $line =~ /^\s*#/) { next; }
        chomp $line;
				if ($should_number_lines) {
	        	print "$should_number_lines. $line\n";
						++$should_number_lines;
				} else { print "$line\n"; }
    }
}

foreach (@ARGV) {
		if ($should_number_lines_for_every_file_separately) { $should_number_lines = 1; }
    print_file $_;
}
