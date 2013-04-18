#! /usr/bin/awk -f
BEGIN{
	RS = "@"
	FS = "\n"
	srand();
	for(i=1;i<=nsample;i++) {
		r = int(rand()*total)+1
		selected[r] = 1
	}
	count = 0
	getline
}
{
	sub("\n$","",$0)
	if ( selected[NR] ) {
		print "@" $0
		count++
		if (count >= nsample)
			exit
	}
}
