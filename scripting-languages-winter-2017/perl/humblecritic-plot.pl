#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Plot data exported from humblecritic

use strict;
use warnings;
use JSON qw( decode_json );

sub parse_json {
    open( my $data, '<:encoding(UTF-8)', $_[0] )
      or die "Could not open file '$_[0]' $!";
    my $json = do { local $/; < $data > };
    return decode_json($json);
}

my @bundles = @{ parse_json($ARGV[0]) };
foreach my $bundle ( @bundles ) {
  print $bundle->{"title"} . "\n";
}
