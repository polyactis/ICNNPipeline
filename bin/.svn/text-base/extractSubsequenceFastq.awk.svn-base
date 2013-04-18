#! /usr/bin/awk -f
BEGIN {
    if ( minSubLen == 0 )
        minSubLen = 15 
}
NR%4==1 {
    id = $1
}
NR%4==2 {
    seq = $1
}
NR%4==0 {
    qual = $1
    seqLen=length(qual)
    for (subLen=minSubLen;subLen<=seqLen;subLen++) {
        for (i=1;i+subLen <= seqLen+1;i++) {
            print id "_start" i "_end" i+subLen-1 "\n" substr(seq,i,subLen) "\n+\n" substr(qual,i,subLen)
        }
    }
}
