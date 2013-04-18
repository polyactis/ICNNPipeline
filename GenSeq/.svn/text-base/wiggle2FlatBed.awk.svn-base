#!/usr/bin/awk -f
BEGIN{
	RS = "fixedStep "
	FS = "\n"
	getline
}
{
	if (match($1,"chrom=chr[0-9MXY]*") )
		chr=substr($1,RSTART+6,RLENGTH-6)
	if ( match($1,"start=[0-9]+") ) 
		start=substr($1,RSTART+6,RLENGTH-6)
	if ( match($1,"step=[0-9]+") ) 
		step = substr($1,RSTART+5,RLENGTH-5)
	len = NF - 2
	maxHeight = 0;
	delete val
	for (i=2; i < NF; i++) {
		if (maxHeight < $i) {
			maxHeight = $i
		}
		val[$i]=1
	}
	print chr "\t" start-1 "\t" step*(start+len-1) "\t" NR "\t" maxHeight 
}
