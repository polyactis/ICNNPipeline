#! /usr/bin/awk -f
NR%4==1{ id = $1}
NR%4==2{ seq = $1 }
NR%4==0{ qual = $1 
    len = length(qual) < length(seq)? length(qual):length(seq)
    print "@" id "\n" substr(seq,1,len) "\n+\n" substr(qual,1,len)
}
