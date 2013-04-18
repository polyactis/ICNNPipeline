#! /usr/bin/awk -f
BEGIN{
    if (length(ARGV) == 1) {
        print stdin not accepted
        exit
    }
    ("wc -l " ARGV[1] "| awk '{print $1}'") | getline total
	srand(systime());
	for(i=0;i<nsample;i++) {
		r = int(rand()*total)+1
		selected[r]++
	}
}
{
	if ( selected[NR] ) {
        ++count
        print
    }
    if (count >= nsample) exit
}
