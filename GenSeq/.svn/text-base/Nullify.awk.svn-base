#!/usr/bin/awk -f
BEGIN{
	printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	for (i=1;i <= length(printable);i++) {
		A[substr(printable,i,1)] = i+31
	}
    if (q == 0) {
        print "quality threshold required"
        exit 1
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
	split(qual,str,"")
    readLen = length(str)
	for(i=readLen; i>=1; i--) {        
        if (A[str[i]]-q > 0) {
            break
        }
	}    
    if ( i < 20 ) 
        next 
    print id "\n" substr(seq,1,i) "\n+\n" substr(qual,1,i)
}
