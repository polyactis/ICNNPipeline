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
    tagDir = "default.Ntail"
    if ( length(ARGV) > 1) {
        cmd = "head -2 " ARGV[1] "|tail -1 | awk '{print length($1)}'" 
        cmd | getline readLen
        tagDir = ARGV[1]
        sub(/.fastq$/,".Ntail",tagDir)
    }
    if (q == 0) {
        print "quality threshold required"
        exit
    }   
    cmd = "rm -rf " tagDir "; mkdir " tagDir
    system(cmd)
}
{
    if (readLen == 0) readLen = length($4)
	seq = ""	
    count=0
	for(i=1;i<=readLen;i++) {        
        if (A[substr($4,i,1)]+0 <= q) {
            seq = seq "N"
            count++
        }
        else {
            seq = seq substr($2,i,1)
        }
	}
    print RS $1 "\n" seq "\n+\n" $4     
    if (count > 0) {
        print $1 >> (tagDir "/" count ".tag")
    }
}
