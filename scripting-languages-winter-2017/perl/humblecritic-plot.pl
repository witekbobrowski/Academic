#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Plot data exported from humblecritic

use utf8;
use strict;
use warnings;
use POSIX;
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

my $plot_dir                 = ".";
my $should_plot_ratings_hist = 0;
my $should_plot_ratings_pts  = 0;

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
"usage: perl humblecritic-plot.pl [-h] [-j JSON_FILE] [-d Directory] [--histogram] [--points]\n\n";
    print "OPTIONS:\n";
    print "    -h, --help     Show help and exit\n";
    print "    -j, --json     JSON input file\n";
    print "    -d, --dir      Directory for dumping plotted charts\n";
    print "    --histogram    Plot ratings histogram\n\n";
    print "    --popularity   Plot item popularity chart\n\n";
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
        elsif ( "$ARGV[$i]" eq "--histogram" ) {
            $expects_files            = 0;
            $should_plot_ratings_hist = 1;
        }
        elsif ( "$ARGV[$i]" eq "--popularity" ) {
            $expects_files            = 0;
            $should_plot_ratings_pts = 1;
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
    my ($bundle)       = shift;
    my @ratings        = ();
    my @ratings_points = ();
    my $url            = $bundle->{"link"};
    my @parsed_url = split( "/", "$url" );
    my $parsed_url = @parsed_url - 1;
    my $name       = $parsed_url[$parsed_url];
    foreach my $tier ( @{ $bundle->{"tiers"} } ) {

        foreach my $item ( @{ $tier->{"items"} } ) {
            my $rating =
              $item->{"average_rating"} eq "" ? 0 : $item->{"average_rating"};
            my $ratings_count =
              $item->{"ratings_count"} eq "" ? 0 : $item->{"ratings_count"};
            my @point = ( $rating, $ratings_count );
            push @ratings, $rating;
            push @ratings_points, [@point];
        }
    }
    my %results = (
        "name"               => $name,
        "bundle"             => $bundle,
        "all_ratings"        => \@ratings,
        "all_ratings_points" => \@ratings_points
    );
    return \%results;
}

sub histogram_data {
    my $ratings = $_[0];
    my @hist    = ();
    foreach my $rating ( @{$ratings} ) {
        $hist[ ceil($rating) ]++;
    }
    return @hist;
}

sub generete_histogram_data_set {
    my ($evaluated_bundle) = shift;
    my @xdata = ();
    my @ydata = histogram_data( $evaluated_bundle->{"all_ratings"} );
    foreach my $index ( 0 .. $#ydata ) {
        push @xdata, $index;
    }
    my $dataSet = Chart::Gnuplot::DataSet->new(
        title => $evaluated_bundle->{"name"},
        xdata => \@xdata,
        ydata => \@ydata,
        fill  => { density => 0.42 },
        style => "histograms",
    );
    return $dataSet;
}

sub generete_popularity_data_set {
    my ($evaluated_bundle) = shift;
    my @points = $evaluated_bundle->{"all_ratings_points"};
    # print Dumper( @points );
    my $dataSet = Chart::Gnuplot::DataSet->new(
        title  => $evaluated_bundle->{"name"},
        pointsize => 3,
        points => @points,
        # fill   => { density => 0.42 },
        style  => "points",
    );
    return $dataSet;
}

sub generate_charts {
    my @bundles = ();
    foreach my $bundle ( (@_) ) {
        my ($evaluated_bundle) = evaluate_bundle($bundle);
        push @bundles, $evaluated_bundle;
    }
    my $ncharts = 0;
    if ( $should_plot_ratings_hist eq 1 ) {
        my $path  = $plot_dir . "/ratings-histogram.png";
        my $chart = Chart::Gnuplot->new(
            output => "$path",
            title  => "Histogram of ratings for items in bundle(s).",
            xlabel => "Rating",
            ylabel => "Occurances of rating",
        );
        my @data_sets = ();
        foreach my $bundle (@bundles) {
            push @data_sets, generete_histogram_data_set($bundle);
        }
        $chart->plot2d(@data_sets);
        $ncharts += 1;
        print "Ratings histogram saved to " . $path . "\n";
    }
    if ( $should_plot_ratings_pts eq 1 ) {
        my $path  = $plot_dir . "/ratings-popularity.png";
        my $chart = Chart::Gnuplot->new(
            output => "$path",
            title  => "Popularity of items in bundle(s).",
            xlabel => "Rating",
            ylabel => "Number of reviews",
        );
        my @data_sets = ();
        foreach my $bundle (@bundles) {
            push @data_sets, generete_popularity_data_set($bundle);
        }
        $chart->set( logscale=>'y' );
        $chart->plot2d(@data_sets);
        $ncharts += 1;
        print "Ratings points saved to " . $path . "\n";
    }
    print $ncharts . " chart(s) generated.\n";
}

# Main program

my @files = evaluate_argumets();
for my $file (@files) {
    my @bundles = parse_json($file);
    generate_charts(@bundles);
}
