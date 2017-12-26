#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print word count for input files

use strict;
use warnings;
use bytes;

# CONSTANTS

my $FILE = "file";
my $WORDS = "words";
my $LINES = "lines";
my $CHARS = "chars";
my $BYTES = "bytes";

# VARIABLES

my $should_print_lines = 0;
my $should_print_words = 0;
my $should_print_characters = 0;
my $should_print_bytes = 0;

my $total_lines = 0;
my $total_words = 0;
my $total_chars = 0;
my $total_bytes = 0;

my $longest_result = 0;

# SUBROUTINES

# Count lines, words, characters, bytes in files
sub word_count {
  my $lines_count = 0;
  my $words_count = 0;
  my $char_count = 0;
  my $byte_count = 0;
  open( my $data, '<:encoding(UTF-8)', $_[0] )
    or die "Could not open file '$_[0]' $!";
  while ( my $line = <$data> ) {
    my @words = split( " ", $line );
    $char_count += length($line);
    $byte_count += bytes::length($line);
    foreach (@words) {
      $words_count += 1;
    }
    $lines_count += 1;
  }
  $total_lines += $lines_count;
  $total_words += $words_count;
  $total_chars += $char_count;
  $total_bytes += $byte_count;
  compare_to_longest_string($lines_count, $words_count, $char_count, $byte_count);
  return ($FILE => $_[0], $LINES => $lines_count, $WORDS => $words_count, $CHARS => $char_count, $BYTES => $byte_count);
}

# Compare lenght of give string to the longest one recorded yet and if longer replace te result
sub compare_to_longest_string {
  for my $string (@_) {
    if (length($string) > $longest_result) {
      $longest_result = length($string);
    }
  }
}

# Evaluate all arguments passed to script, and turn on give flags if needed (if none is set, set default config)
sub evaluate_argumets {
  my @files;
  for my $i (0 .. $#ARGV) {
    if ("$ARGV[$i]" eq "-l" || "$ARGV[$i]" eq "--lines") {
      $should_print_lines = 1;
    } elsif ("$ARGV[$i]" eq "-w" || "$ARGV[$i]" eq "--words" ) {
      $should_print_words = 1;
    } elsif ("$ARGV[$i]" eq "-m" || "$ARGV[$i]" eq "--chars") {
      $should_print_characters = 1;
    } elsif ("$ARGV[$i]" eq "-c" || "$ARGV[$i]" eq "--bytes") {
      $should_print_bytes = 1;
    } else {
      push @files, $ARGV[$i];
    }
  }
  if (($should_print_lines eq 0) && ($should_print_words eq 0) && ($should_print_characters eq 0) && ($should_print_bytes eq 0)) {
    $should_print_lines = 1;
    $should_print_words = 1;
    $should_print_characters = 1;
  }
  return @files;
}

# Format result with appropriate amount of spaces
sub format_result {
  my $n = $longest_result - length($_[0]);
  my $spaces = ( ' ' x $n );
  return "$spaces$_[0]";
}

# Evaluate result from word_count subroutine to readable string
sub get_output {
  my %results = @_;
  my $output = "";
  if ($should_print_lines eq 1) {
    my $formated = format_result($results{$LINES});
    $output = "$output    $formated";
  }
  if ($should_print_words eq 1) {
    my $formated = format_result($results{$WORDS});
    $output = "$output    $formated";
  }
  if ($should_print_characters eq 1) {
    my $formated = format_result($results{$CHARS});
    $output = "$output    $formated";
  }
  if ($should_print_bytes eq 1) {
    my $formated = format_result($results{$BYTES});
    $output = "$output    $formated";
  }
  $output = "$output $results{$FILE}\n";
  return $output;
}

# Main program

my @files = evaluate_argumets();
for my $file (@files){
  print get_output(word_count($file));
}
if ($#files > 1) {
  print get_output(($FILE => "total", $LINES => $total_lines, $WORDS => $total_words, $CHARS => $total_chars, $BYTES => $total_bytes));
}
