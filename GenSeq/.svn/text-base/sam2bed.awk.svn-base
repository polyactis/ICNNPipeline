#!/usr/bin/awk -f
$3 !~ /^\*$/{
    if ( !match($0,/X0:i:[0-9]*/) ) {
        next
    }
    n0 = substr($0,RSTART+5,RLENGTH-5)

    if ( !match($0,/X1:i:[0-9]*/) ) {
        next
    }
    n1 = substr($0,RSTART+5,RLENGTH-5)
    nhit = n0 + n1

    if ( !match($0,/XM:i:[0-9]*/) ) {
        next
    }
    mis = substr($0,RSTART+5,RLENGTH-5)

    readLen = length($10)+0
    if (mis < 0.05 * readLen)
        print $3 "\t" $4-1 "\t" $4+readLen-1 "\t" $1 "\t" nhit "\t" (and($2,0x0010)? "-" : "+") "\t" mis
} 
