#!/usr/bin/awk -f
BEGIN{
	if (length(ARGV) < 2) {
		print "give one wig!"
		exit 1
	}	
	if (readLen == 0) {
		print "set readLen with -v"
		exit 1
	}
	RS = "fixedStep "
	FS = "\n"
	getline
	sub("\n+$","",$0)
	sub(".chr10 visibility"," visibility",$0) #hack!
#	sub("name=","name=purged.",$0)
	if (ARGV[1] ~ /\.F\.wig/ ) {
		$0 = $0 " color=255,69,0"
	}
	else{
		if ( ARGV[1] ~ /\.R\.wig/ ) 
			$0 = $0 " color=60,179,113"
	}			
	print

	statFile = ARGV[1] ".stat"
	system(">" statFile)
	OFS = "\n"
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
	print chr "\t" start "\t" start+len-1 "\t" length(val) "\t" maxHeight >>  statFile
	if (maxHeight > 1 || len > readLen) {
		sub("\n+$","",$0)
		print RS $0
	}
}
