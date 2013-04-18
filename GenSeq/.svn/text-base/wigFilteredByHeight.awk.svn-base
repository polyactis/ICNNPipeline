#!/usr/bin/awk -f
BEGIN{
	RS = "\nfixedStep "
	FS = "\n"
    OFS = FS
	getline header
    print header
    preEnd = 0
    preChr = "chr"
    statFile = ARGV[1] ".peakStat"
    system(">" statFile)
}
{
	if (!match($1,"chrom=chr[0-9MXY]*"))    next 
    chr=substr($1,RSTART+6,RLENGTH-6)
	
    if (!match($1,"start=[0-9]+"))  next
    start=substr($1,RSTART+6,RLENGTH-6)
	
    if (!match($1,"step=[0-9]+"))   next
	step = substr($1,RSTART+5,RLENGTH-5)

	len = (NF - 1)*step
    end = start + len
    start = start > 0? start-1:0
	height = $2;
	for (i=3; i <= NF; i++) {
        height = (height < $i) ? $i : height
	}
    if (height >= baseline)   print "fixedStep " $0

    if (chr == preChr)
        print height "\t" start+1-preEnd >> statFile

    preEnd = end
    preChr = chr
}



