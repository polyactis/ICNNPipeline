#!/usr/bin/awk -f
NR%4==1 {
    gsub(/ +/,"#",$0)
    id = $0
}
NR%4==2 {
    seq = $1
}
NR%4==0 {
    print id "\t" seq "\t" $0
}
