#!/usr/bin/awk -f
{
	split($10,start,",")
	split($11,end,",")

    numExon = length(start) - 1 
    if (numExon != $9 || numExon != length(end)-1) {
        system("echo bad record in refFlat: " $0 "1>&2")
        next
    }

#geneID = $1 ":" $2 ":" $3 ":" $4 ":" NR
    geneID = $1 
    txStart = $7   
    txEnd = $8  
    len = 0;
    for(i=1; i <= numExon; i++) {
        len += end[i] - start[i]
    }
	for(i=1; i <= numExon; i++) {
        s = start[i]
        e = end[i]
# if utr exon and cds exon are adjacent, they are put together in the UCSC ref* files
# so we split them here
        if (txStart - s > 0 && txStart - e < 0) {
            print $3 "\t" s "\t" txStart "\t" geneID "\t" len "\t" $4        
            s = txStart
        }
        if (txEnd - s > 0 && txEnd - e < 0) {
            print $3 "\t" txEnd "\t" e "\t" geneID "\t" len "\t" $4
            e = txEnd
        }
        print $3 "\t" s "\t" e "\t" geneID "\t" len "\t" $4
	}
}
