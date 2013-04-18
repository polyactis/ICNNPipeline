#!/usr/bin/awk -f
{
# need 6 colums for the standard bed format. Use exon count ($9) in the score column
#	chr txStart txEnd geneSymbol score strand
#	print $3 "\t" $5 "\t" $6 "\t" $1 "\t" $9 "\t" $4 "\t" $2
    gene = $1 ":" $2 ":" $3 ":" $4 ":" NR
    if (count[gene] == 0 || start[gene] > $5)
        start[gene] = $5
    if (count[gene] == 0 || end[gene] < $6)
        end[gene] = $6
    count[gene]++
}
END{
    for(g in count) {
        split(g,A,":")
        print A[3] "\t" start[g] "\t" end[g] "\t" g 
    }
}
        
    
