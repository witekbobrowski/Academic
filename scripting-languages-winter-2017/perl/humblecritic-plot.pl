#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Plot data exported from humblecritic

use strict;
use warnings;

eval {
    require JSON::MaybeXS;
    JSON::MaybeXS->import();
    1;
} or print_help("[ERROR] Please install JSON::MaybeXS module.\n\n");

sub parse_json {
    open( my $data, '<:encoding(UTF-8)', $_[0] )
      or die "Could not open file '$_[0]' $!";
    my $str = "";
    while ( my $line = <$data> ) {
        $str = "$str$line";
    }
    my @json = @{ decode_json($str) };
    return @json;
}

sub print_help {
    print(@_);
    print
      "This script uses data scraped by the humblecritic python script \n\n";
    print "usage: perl humblecritic-plot.pl [-h] [-j JSON_FILE]\n\n";
    print "OPTIONS:\n";
    print "    -h, --help   Show help and exit\n";
    print "    -j, --json   JSON input file\n\n";
    print "MODULES:\n";
    print "    JSON::MaybeXS\n\n";
    print "    You can install them by running (sudo) cpan <module>\n";
    exit(0);
}

sub evaluate_argumets {
    my $expects_files = 0;
    my @files;
    for my $i ( 0 .. $#ARGV ) {
        if ( "$ARGV[$i]" eq "-h" || "$ARGV[$i]" eq "--help" ) {
            print_help();
        }
        elsif ( "$ARGV[$i]" eq "-j" || "$ARGV[$i]" eq "--json" ) {
            $expects_files = 1;
        }
        else {
            if ( $expects_files eq 1 ) {
                push @files, $ARGV[$i];
            }
            else {
                print_help("[ERROR] Invalid use of options.\n\n");
            }
        }
    }
    if ( $#files eq -1 ) {
        print_help("[ERROR] Please supply json files after '--json' flag.\n\n");
    }
    return @files;
}

my @files = evaluate_argumets();
for my $file (@files) {
    my @bundles = parse_json($file);
    foreach my $bundle (@bundles) {
        print "$bundle->{'title'} \n";
    }
}
