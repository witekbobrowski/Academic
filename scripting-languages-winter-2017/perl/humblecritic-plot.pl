#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Plot data exported from humblecritic

use utf8;
use strict;
use warnings;
use Scalar::Util;
use Data::Dumper;

binmode STDOUT, ":encoding(UTF-8)";

eval {
    require JSON::MaybeXS;
    JSON::MaybeXS->import();
    1;
} or print_help("[ERROR] Please install JSON::MaybeXS module.\n\n");
eval {
    require Chart::Gnuplot;
    Chart::Gnuplot->import();
    1;
} or print_help("[ERROR] Please install Chart::Gnuplot module.\n\n");

my $plot_dir                  = "";
my $should_plot_ratings_share = 0;

# Subroutines

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
"This script uses data scraped by the humblecritic python script and plots charts.\n\n";
    print
"usage: perl humblecritic-plot.pl [-h] [-j JSON_FILE] [-d Directory] [-r]\n\n";
    print "OPTIONS:\n";
    print "    -h, --help     Show help and exit\n";
    print "    -j, --json     JSON input file\n";
    print "    -d, --dir      Directory for dumping plotted charts\n";
    print "    -r, --ratings  Plot ratings share\n\n";
    print "MODULES:\n";
    print "    JSON::MaybeXS\n";
    print "    Chart::Gnuplot\n\n";
    print "    You can install them by running (sudo) cpan <module>\n";
    exit(0);
}

sub evaluate_argumets {
    my $expects_files = 0;
    my $expects_dir   = 0;
    my @files;
    for my $i ( 0 .. $#ARGV ) {
        if ( "$ARGV[$i]" eq "-h" || "$ARGV[$i]" eq "--help" ) {
            print_help();
        }
        elsif ( "$ARGV[$i]" eq "-j" || "$ARGV[$i]" eq "--json" ) {
            $expects_files = 1;
            $expects_dir   = 0;
        }
        elsif ( "$ARGV[$i]" eq "-d" || "$ARGV[$i]" eq "--dir" ) {
            $expects_files = 0;
            $expects_dir   = 1;
        }
        elsif ( "$ARGV[$i]" eq "-r" || "$ARGV[$i]" eq "--ratings" ) {
            $expects_files             = 0;
            $should_plot_ratings_share = 1;
        }
        else {
            if ( ( $expects_files eq 1 ) && ( $expects_dir eq 0 ) ) {
                push @files, $ARGV[$i];
            }
            elsif ( $expects_dir eq 1 ) {
                $plot_dir    = $ARGV[$i];
                $expects_dir = 0;
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

sub evaluate_bundle {
    my $bundle  = $_[0];
    my @ratings = ();
    foreach my $tier ( @{ $bundle->{"tiers"} } ) {
        foreach my $item ( @{ $tier->{"items"} } ) {
            push @ratings, $item->{"average_rating"};
        }
    }
    return ( "bundle" => $bundle, "all_ratings" => [@ratings] );
}

sub generate_plots {
    my (%evaluated_bundle) = @_;
    my $title              = $evaluated_bundle{"bundle"}{"title"};
    my $url                = $evaluated_bundle{"bundle"}{"link"};
    my @parsed_url = split( "/", "$url" );
    my $parsed_url = @parsed_url - 1;
    my $name       = $parsed_url[$parsed_url];
    if ( $should_plot_ratings_share eq 1 ) {
        my $data  = $evaluated_bundle{"all_ratings"};
        my $path  = $plot_dir . $name . "-ratings-share.png";
        my $chart = Chart::Gnuplot->new(
            output => "$path",
            title  => "Share of ratings for items in " . $title,
            xlabel => "Rating",
            ylabel => "Occurances of rating",
        );
        my $dataSet = Chart::Gnuplot::DataSet->new(
            ydata => \@{$data},
            fill  => { density => 0.4 },
            color => "dark-green",
            style => "boxes",
        );
        $chart->plot2d($dataSet);
        print "Rating chart saved to " . $path . "\n";
    }
}

# Main program

my @files = evaluate_argumets();
for my $file (@files) {
    my @bundles = parse_json($file);
    foreach my $bundle (@bundles) {
        generate_plots( evaluate_bundle($bundle) );
    }
}
