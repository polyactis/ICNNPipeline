#!/usr/bin/awk -f
!/^#/{
	split($10,start,",")
	split($11,end,",")

# cheking quality of input data
    numExon = length(start) - 1 
    if (numExon != $9 || numExon != length(end)-1) {
        print "bad record in refFlat: " $0
        exit 1
    }
    strand = $4
    geneID = $13 ":"$2 ":" $3 ":" $4 ":" NR
    cdsStart = $7   
    cdsEnd = $8  

    split("",exon)
    len = 0
	for(i=1; i <= numExon; i++) {
        s = start[i]
        e = end[i]
        len += e-s
# if utr exon and cds exon are adjacent, they are put together in the UCSC ref* files
# so we split them here
        if (cdsStart - s > 0 && cdsStart - e < 0) {
            exon[length(exon)+1] = $3 "\t" s "\t" cdsStart
            s = cdsStart
        }
        if (cdsEnd - s > 0 && cdsEnd - e < 0) {
            exon[length(exon)+1] = $3 "\t" cdsEnd "\t" e
            e = cdsEnd
        }
        exon[length(exon)+1] = $3 "\t" s "\t" e 
	}
    for (i=1;i<=length(exon); i++) {
        print exon[i] "\t" geneID "\t" len "\t" strand
    }
}
