#! /usr/bin/awk -f
BEGIN {
    printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    split(printable,table,"")
    for (i=1; i<length(table); i++) {
        asciiCode[table[i]] = i + 32
    }
}
{   
    if (NR%4==0) {
        qual = ""
        split($1,Q,"")
        for (i=1; i<=length(Q); i++) {
            qual = qual table[asciiCode[Q[i]]-31-32]
        }
        print qual
    }
    else {
        print
    }
}

