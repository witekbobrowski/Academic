#!/usr/bin/perl
# Witold Bobrowski ; Group 2
#
# Print file line-by-line excluding comments (#)

sub print_file {
    open(my $data, '<:encoding(UTF-8)', $_[0])
        or die "Could not open file '$_[0]' $!";
    print "\n--------------------------------------------------------------\n";
    print "$_[0]\n";
    print "--------------------------------------------------------------\n\n";
    while (my $line = <$data>) {
        if ($line =~ /^\s*#/) { next; }
        chomp $line;
        print "$line\n";
    }
}


foreach (@ARGV) {
    print_file $_;
}
