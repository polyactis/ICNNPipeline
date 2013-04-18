#!/usr/bin/awk -f
BEGIN{
    "date +%s" | getline _seed   
#    procid = "'"$$"'" 
#    print "time=" _seed "\t" "procid=" procid 

    srand(_seed + procid)
}
{
    line[NR]=$0
}
END{
    for (i=NR; i > 0; i--) {
        j=int(rand()*i) + 1
        print line[j]
        line[j]=line[i]
    }
}
