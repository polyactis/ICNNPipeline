#! /usr/bin/awk -f
NR%4==1 {
    id = $1
}
NR%4==2 {
    seq = $1
}
NR%4==0 {
    if ( length(seq) == length($1) && length(seq) >= minLen ) {
        print id "\n" seq "\n+\n" qual
    }
}
    
