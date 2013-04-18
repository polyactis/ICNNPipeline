#!/usr/bin/awk -f
!/^#/{
	split($10,start,",")
	split($11,end,",")

# cheking quality of input data
    numExon = length(start) - 1 
    if (numExon != $9 || numExon != length(end)-1) {
        next
#        print "bad record in refFlat: " $0
#       exit 1
    }
    strand = $4
    geneID = $13
    cdsStart = $7   
    cdsEnd = $8  

	for(i=1; i <= numExon; i++) {
        s = start[i]
        e = end[i]
# if utr exon and cds exon are adjacent, they are put together in the UCSC ref* files
# so we split them here
        if (cdsStart - s > 0 && cdsStart - e < 0) {
            print $3 "\t" s "\t" cdsStart "\t" geneID "\t" 0 "\t" $4        
            s = cdsStart
        }
        if (cdsEnd - s > 0 && cdsEnd - e < 0) {
            print $3 "\t" cdsEnd "\t" e "\t" geneID "\t" 0 "\t" $4
            e = cdsEnd
        }
        print $3 "\t" s "\t" e "\t" geneID "\t" 0 "\t" $4
	}
}
