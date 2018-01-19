#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Parse text file of students with grades and generate registry

use strict;
use warnings;
use Utils;
use File::Basename;

#TODO: - Add documentation

my $longest_name_length = 0;
my $longest_grade       = 0;
my $longest_list        = 0;

sub evaluate_inout_file {
    my %registry;
    open( my $data, '<:encoding(UTF-8)', $_[0] )
      or die "Could not open file '$_[0]' $!";
    while ( my $line = <$data> ) {
        $line =~ s/[\r\n]+$//;
        my @info       = split / /, $line;
        my $first_name = lc "$info[0]";
        my $last_name  = lc "$info[1]";
        compare_to_longest_name("$last_name $first_name");
        my $grade = Utils::get_grade( $info[2] );
        if ( $grade == 0 ) {
            print STDERR
"WARNING! \"$info[2]\" is not a valid grade, therefore it will be ignored\n";
        }
        else {
            compare_to_longest_grade($grade);
            push @{ $registry{"$last_name-$first_name"} }, $grade;
        }
    }
    return \%registry;
}

sub format_name {
    my @names      = split /-/, "$_[0]";
    my $last_name  = ucfirst $names[0];
    my $first_name = ucfirst $names[1];
    my $result     = "$last_name $first_name";
    my $n          = $longest_name_length - length($result);
    my $spaces     = ( ' ' x $n );
    return "  $spaces$result";
}

sub format_grade {
    my $n      = $longest_grade - length("$_[0]");
    my $spaces = ( ' ' x $n );
    return "$spaces$_[0]";
}

sub compare_to_longest_name {
    for my $string (@_) {
        if ( length($string) > $longest_name_length ) {
            $longest_name_length = length($string);
        }
    }
}

sub compare_to_longest_grade {
    for my $string (@_) {
        if ( length($string) > $longest_grade ) {
            $longest_grade = length($string);
        }
    }
}

sub generate_output_files {
    my %registry               = %{ $_[0] };
    my $file_name              = basename( $_[1] );
    my $output                 = "";
    my $total_sum              = 0;
    my $total_number_of_grades = 0;
    foreach my $student ( sort keys %registry ) {
        my $sum              = 0;
        my $number_of_grades = 0;
        my $name             = format_name($student);
        $output = "$output$name    [ ";
        foreach my $grade ( @{ $registry{$student} } ) {
            my $formated = format_grade($grade);
            $output = "$output$formated, ";
            $sum += $grade;
            $number_of_grades += 1;
        }
        my $average = $sum / $number_of_grades;
        $output = "$output]  Average: $average \n";
        $total_sum              += $sum;
        $total_number_of_grades += $number_of_grades;
    }
    my $n       = $longest_name_length - length($file_name);
    my $spaces  = ( '-' x $n );
    my $average = $total_sum / $total_number_of_grades;
    return
      "--$spaces$file_name - Average for all students: $average\n$output\n";
}

# Main program
foreach my $i ( 0 .. $#ARGV ) {
    my $file = "$ARGV[$i]";
    print generate_output_files( evaluate_inout_file($file), $file );
}
