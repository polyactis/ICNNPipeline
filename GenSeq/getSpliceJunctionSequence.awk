#! /usr/bin/awk -f
# input: exonUTR.refFlat.bed.fasta exonUTR.refFlat.bed
# exons of the same gene comes consecutively in exonUTR.refFlat.bed
{   
    if (FILENAME == ARGV[1]) {
        fasta[$1] = $2
        next
    }
    
    strand = $6
    curGene = $4 $6 $1
    # starting another gene 
    if (prevGene != curGene) {
        if ( prevGene != "" ) {
            printJunctions(prevGene)
        }
        split("",exon)
    }
    prevGene = curGene
    e = $1 ":" $2 "-" $3 
    exon[length(exon)+1] = e
}
END {
    printJunctions(prevGene)
}

function printJunctions(prevGene) {
    for (i=1; i<=length(exon); i++) {
        for (j=i+1; j<=length(exon); j++) {
            print ">" prevGene "#" strand exon[i] "#" strand exon[j]
            print fasta[exon[i]] fasta[exon[j]]
        }
    }
}
