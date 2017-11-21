#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print file line-by-line

use strict;
use warnings;
use Getopt::Long qw(:config no_ignore_case);

my $should_hide_comments = 0;
my $should_show_all_lines = 0;
my $should_number_lines = 0;
my $should_number_lines_for_every_file_separately = 0;

sub print_file {
    open(my $data, '<:encoding(UTF-8)', $_[0])
        or die "Could not open file '$_[0]' $!";
    while (my $line = <$data>) {
      my $output = $line;
      if ( $should_hide_comments && $line =~ /^\s*#/) {
        if ($should_show_all_lines) {
          $output = "";
        } else { next; }
      }
      chomp $output;
			if ($should_number_lines) {
	     	print "$should_number_lines. $output\n";
				++$should_number_lines;
			} else { print "$output\n"; }
    }
}

GetOptions(
    'N' => \$should_hide_comments,
    'c' => \$should_number_lines,
    'n' => \$should_show_all_lines,
    'p' => \$should_number_lines_for_every_file_separately,
) or die "Incorrect usage!\n";

foreach (@ARGV) {
		if ($should_number_lines_for_every_file_separately) { $should_number_lines = 1; }
    print_file $_;
}
