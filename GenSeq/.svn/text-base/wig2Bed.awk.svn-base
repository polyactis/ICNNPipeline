#!/usr/bin/awk -f
BEGIN{
	RS = "\nfixedStep "
	FS = "\n"
	getline
}
{
	if (!match($1,"chrom=chr[0-9MXY]*"))    next 
    chr=substr($1,RSTART+6,RLENGTH-6)
	
    if (!match($1,"start=[0-9]+"))  next
    start=substr($1,RSTART+6,RLENGTH-6)
	
    if (!match($1,"step=[0-9]+"))   next
	step = substr($1,RSTART+5,RLENGTH-5)

	len = (NF - 1)*step
    start = start > 0? start-1:0
    end = start + len
	height = 0;
	for (i=2; i <= NF; i++) {
		if (height < $i) height = $i
	}
	print chr "\t" start "\t" end "\t" 0 "\t" height "\t0\t" len
}

