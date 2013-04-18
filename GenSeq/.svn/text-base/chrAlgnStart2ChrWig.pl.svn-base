#!/usr/bin/perl

use strict;
use warnings;

if (@ARGV < 3) {
	die("paramters: algnFileName readLen minDepth\n");
}
# assuming that algnFileName contains sorted coordinates (starting positions) of alignments to a single chrosome 
my $algnFileName = $ARGV[0];

open(FILE,"$algnFileName") or die("can't open $algnFileName");

my $readLen = $ARGV[1];

my $minDepth = $ARGV[2];

my $chrNum = "chrRandom";
if ( $algnFileName =~ /\.(chr[0-9XYM]*)$/ ) {
	$chrNum = $1;
}
else {
	exit;	
}

my @algn = ();

while (<FILE> ) {
	chomp;
	my ($loc) = split(/\s+/);
	push @algn, $loc;
}
close(FILE);

@algn = sort {$a <=> $b} @algn;

#print "track type=wiggle_0 name=$algnFileName visibility=full priority=1 maxHeightPixels=50 autoScale=on\n";

my $cur = -1;
my $val = -1;
my @inc = ();
my @end = ();

# more reads (@algn > 0), or within a read to write (@end > 0)
while (@algn > 0 || @end > 0) {
	if (@end > 0) {
		my $nextCur = (@algn == 0 || $end[0] < $algn[0]) ? $end[0] + 1 : $algn[0];		
		if ($val >= $minDepth) {
			print join("\n",($val)x($nextCur - $cur)) . "\n";
		}
		$cur = $nextCur;
		if ( $end[0] == $cur - 1) {
			$val -= shift(@inc);
			shift(@end);
			
		}
		# this IF can still happen after the above IF!
		if ( @algn > 0 && $algn[0] == $cur ) {
			my $i = 0;
			while (@algn > 0 && $cur == $algn[0] ) {
				$i++;
				shift(@algn);
			}
			$val += $i;
			push @end, $cur + $readLen-1;
			push @inc, $i;
#			print "1 => \@end: " . join ("\t",@end) . "\n";
		}
	}
	else {
		$cur = shift(@algn);
#		print "\@$cur\n";
		print "fixedStep chrom=$chrNum start=$cur step=1\n";
		$val = 1;
		while (@algn > 0 && $cur == $algn[0] ) {
			$val++;
			shift(@algn);
		}
		push @end, $cur + $readLen-1;
		push @inc, $val;
#		print "1 => \@end: " . join ("\t",@end) . "\n";
	}
}




