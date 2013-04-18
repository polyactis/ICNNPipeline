#! /usr/bin/awk -f
{
    gene = $1":::::"$4   
    if ( start[gene] == 0 || start[gene]-$2>0 ) {
        start[gene] = $2
    }
    
    if ( end[gene] - $3 < 0) {
        end[gene] = $3
    }
}
END {
    for (i in start) {
        split(i,A,":::::")
        print A[1] "\t" start[i] "\t" end[i] "\t" A[2]
    }
}
