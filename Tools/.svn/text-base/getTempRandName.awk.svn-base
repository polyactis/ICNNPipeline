#!/usr/bin/awk -f
BEGIN { 
#srand(systime()) # gawk
    "date +%s" | getline _seed   
#    procid = "'"$$"'" 
#    print "time=" _seed "\t" "procid=" procid 

    srand(_seed + procid)
    ascii="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    len = 32
    for (i=0; i < len; i++) {
        label = label substr(ascii,int(rand()*length(ascii))+1,1)
    }
    print "tempRandLabel." label
}
