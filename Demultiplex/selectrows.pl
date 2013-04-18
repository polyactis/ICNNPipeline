#!/usr/bin/perl

# The first argument is the name of a file containing newline-separated
# row numbers. Select these rows from STDIN and print to STDOUT.

if($#ARGV<0) {
 die "Missing row file on command line\n";
}

open(ROWS, "$ARGV[0]") or die "Couldn't open row file\n";
while(<ROWS>) {
 chomp;
 $a{int($_)} = 1;
}
close(ROWS);

for($r=1; $l=<STDIN>; ++$r) {
 if($a{$r}) {
   print $l;
 }
}
