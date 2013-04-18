#!/usr/bin/awk -f
BEGIN{
	printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	for (i=1;i <= length(printable);i++) {
		A[substr(printable,i,1)] = i+32
	}
	RS = "@"
	FS = "\n"
	getline
    Q = -10 * log(0.5/L)/log(10) + 64
}
{
	minQual = 1e+6
	for(i=1;i<=L;i++) {
        if (minQual-A[substr($4,i,1)]>0)		
            minQual = A[substr($4,i,1)]
	}
    if (minQual >= Q) {
        print "@" $1 "\n" substr($2,1,L) "\n+\n" substr($4,1,L)
    }
}
