#! /usr/bin/awk -f
NR%4==1 {
    id = $1
}
NR%4==2 {
    seq = $1
}
NR%4==0 {
    qual = $1
    if ( match(seq,contam) ) {
        seq = substr(seq,RSTART+RLENGTH)
        qual = substr(qual,RSTART+RLENGTH)
    }
    if ( length(seq) >= 20)
        print id "\n" seq "\n+\n" qual
}
