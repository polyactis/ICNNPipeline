#!/usr/bin/awk -f
BEGIN{
	printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	for (i=1;i <= length(printable);i++) {
		A[substr(printable,i,1)] = i+32
	}
    if (q == 0) {
        print "quality threshold required"
        exit
    }   
    if (L == 0) {
        print "max len required"
        exit
    }   
}
NR%4 == 1 {
    id = $1
}
NR%4 == 2 {
    seq = $1 
}
NR%4 == 0 {
    qual = $1
    qual = substr(qual,1,L)
    readLen = length(qual)
#    tailAveQual = 0
    tailGoodCount = 0
    not yet finish 

	for(i=readLen - int(readLen;i>=10;i--) {        
#        tailAveQual = (tailAveQual * (readLen - i) + A[substr(qual,i,1)])/(readLen - i + 1)
#        if (tailAveQual - q >= 0) {
        tailGoodCount += ( A[substr(qual,i,1)] - q >= 0 )
        if ( 2 * tailGoodCount - (readLen - i + 1) >= 0 ) {
            break
        }
	}    
    if ( i < 20 ) 
        next 
    print id "\n" substr(seq,1,i) "\n+\n" substr(qual,1,i)
}
