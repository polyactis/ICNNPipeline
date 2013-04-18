#!/usr/bin/awk -f
BEGIN{
	RS=">"
	FS="\n"
    getline
    if (len==0) len=50
}
{
    seq = $2;
    for(i=3;i<NF;i++) {
        if ($i ~ / $/)  gsub(/ +/,"",$i)
        seq = seq $i
    }
    print ">" $1 
    L = length(seq)
    for(i=1;i<=L;i+=len) {
        l = i+len-1<=L ? len : L-i+1
        print substr(seq,i,l)
    }
}
