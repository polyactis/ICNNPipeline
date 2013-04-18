#!/usr/bin/awk -f
BEGIN{
	printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	for (i=1;i <= length(printable);i++) {
		A[substr(printable,i,1)] = i+32
	}
	RS = "@"
	FS = "\n"
	getline
    readLen = 0
    if ( length(ARGV) > 1) {
        cmd = "head -2 " ARGV[1] "|tail -1 | awk '{print length($1)}'" 
        cmd | getline readLen
    }
    if (q == 0) {
        print "quality threshold required"
        exit
    }   
}
{
    if (readLen == 0) readLen = length($4)
    
    split($4,qualArray,"")

	for(i=readLen;i>=1;i--) {        
        if (A[qualArray[i]] - q > 0) {
            break
        }
	}    
    if ( i < 20 ) 
        next 

    split(substr($2,1,i),seqArray,"")
    seq=""
    for (j=1;j <=i ; j++) {
        seq = seq (A[qualArray[j]]-q>0 ? seqArray[j] : "N")
    }
    print RS $1 "\n" seq "\n+\n" substr($4,1,i)
}
