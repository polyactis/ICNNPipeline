#! /usr/bin/awk -f
FILENAME == ARGV[1]{
# exon id = gene strand chr start end
    exon[$4 $6 $1 ":" $2 "-" $3] = $7 
}
FILENAME == ARGV[2]{
    junction[$1] = $2
}    
FILENAME == ARGV[3]{
    split($10,start,",")
    split($11,end,",")
    id = $1 "#" $2 "#" $3 "#" $4 "#" NR   
    for(i=1; i <= $9;i++) {
        for(shift=-1;shift<=1;shift++) {
            eID = $1 $4 $3 ":" (start[i]+shift) "-" end[i]
            if (exon[eID] > 0) {
                count[id] += exon[eID]
                break
            }
        }
        for(j=i+1; j<= $9; j++) {
            for(shift=-1;shift<=1;shift++) {
                juncID = $1 $4 $3 "#" $4 $3 ":" (start[i]+shift) "-" end[i] "#" $4 $3 ":" (start[j]+shift) "-" end[j]
                if (junction[juncID] > 0) {
                    count[id] += junction[juncID]
                    break
                }
        }
        }
        len[id] += end[i] - start[i]
    }
}
END{
    for (id in count) {
        print id "\t" count[id] "\t" len[id]
    }
}
