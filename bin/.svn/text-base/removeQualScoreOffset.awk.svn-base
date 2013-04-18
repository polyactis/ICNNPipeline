#! /usr/bin/awk -f
BEGIN {
    offset = 64
    printable="!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
	for (i=1;i <= length(printable);i++) {
		c2n[substr(printable,i,1)] = i+32
        n2c[i+32] = substr(printable,i,1)
    }
    OFS = "\t"
}
{
    split($11,qualChar,"")
    qual = ""    
    for (i=1;i<=length(qualChar);i++) {
        qual = qual n2c[ c2n[qualChar[i]] - offset ]
    }
    $11 = qual
    print $0
}
