#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Parse text file of students with grades and generate registry

use strict;
use warnings;
use Utils;
use File::Basename;

# VARIABLES

my $longest_name_length = 0;
my $longest_grade       = 0;
my $longest_list        = 0;

# SUBROUTINES

# Parse file contents into a hash table
# Arguments:
#   1) string - file name
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

# Format array of student names into a one string prefixed with approproate amount of spaces
# Arguments:
#   1) string array - Array of names [$first_name, $last_name]
sub format_name {
    my @names      = split /-/, "$_[0]";
    my $last_name  = ucfirst $names[0];
    my $first_name = ucfirst $names[1];
    my $result     = "$last_name $first_name";
    my $n          = $longest_name_length - length($result);
    my $spaces     = ( ' ' x $n );
    return "  $spaces$result";
}

# Format grade by prefixing with approproate amount of spaces
# Arguments:
#   1) float - grade
sub format_grade {
    my $n      = $longest_grade - length("$_[0]");
    my $spaces = ( ' ' x $n );
    return "$spaces$_[0]";
}

# Compare given full name with the longest yet recorded, replace if it's longer
# Arguments:
#   1) string - fullname
sub compare_to_longest_name {
    for my $string (@_) {
        if ( length($string) > $longest_name_length ) {
            $longest_name_length = length($string);
        }
    }
}

# Compare given grade with the longest yet recorded, replace if it's longer
# Arguments:
#   1) string - grade
sub compare_to_longest_grade {
    for my $string (@_) {
        if ( length($string) > $longest_grade ) {
            $longest_grade = length($string);
        }
    }
}

# Create and return string with sorted students with their grades and average
# Arguments:
#   1) hash array reference - dictionary of grades for each students
#   2) string - file name
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
