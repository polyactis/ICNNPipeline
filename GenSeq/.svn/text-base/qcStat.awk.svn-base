#!/usr/bin/awk -f 
BEGIN{
    maxMis = 5
    for (i=0;i<=maxMis;i++){ 
        uniqueMisCount[0] = 0
        goodMisCount[0] = 0
        bothMisCount[0] = 0
    }
    bedFile = ARGV[1] ".uniqueAlgn.bed" 
    system(">" bedFile)
}
{
    tag = $1
    len = length($10)
    $1 = ""; $10 = ""; $11 = ""
    isUnique = /\<X0:i:1\>/ && /\<X1:i:0\>/
    isGood = $5 > 30
    match($0,"XM:i:[0-9]*")
    nmis = substr($0,RSTART+5,RLENGTH-5)    
    if (isUnique){
        uniqueMisCount[nmis]++
        print $3 "\t" $4-1 "\t" $4+len-1 "\t" tag "\t" nmis "\t" (and($2,0x0010)? "-" : "+") >> bedFile
        if (isGood) {
            bothMisCount[nmis]++
        }
    }
    if (isGood) {
        goodMisCount[nmis]++
    }
}
END {
    out = uniqueMisCount[0]
    for (i=1;i<=maxMis;i++) {
       out = out "\t" uniqueMisCount[i]+0
    }
    out = out "\t" goodMisCount[0]
    for (i=1;i<=maxMis;i++) {
       out = out "\t" goodMisCount[i]+0      
    }
    out = out "\t" bothMisCount[0]
    for (i=1;i<=maxMis;i++) {
       out = out "\t" bothMisCount[i]+0
    }
    print NR "\t" out > ARGV[1] ".qcStat"
}
