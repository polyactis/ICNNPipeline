#!/usr/bin/awk -f
BEGIN {
    OFS = "\t"
    getline
    $5 = ""
    print $0 > (ARGV[1] ".ave")
    print $0 > (ARGV[1] ".max")
}
{
    id = $1 "\t" $2 "\t" $3 "\t" $4
    split(ave[id],A,OFS)
    split(max[id],M,OFS)
    split(count[id],C,OFS)
    for (i=1;i<=NF-5;i++){
        A[i] += $(i+5)
        C[i]++
        if (M[i] < $(i+5))
            M[i] = $(i+5)
        ave[id] = (i==1?"":ave[id] OFS)  A[i]
        max[id] = (i==1?"":max[id] OFS) M[i]
        count[id] = (i==1?"":count[id] OFS) C[i]       
    }
}
END {
    for (i in ave) {
        split(ave[i],A,OFS)
        split(count[i],C,OFS)
        a = ""
        for (j=1;j<=NF-5;j++) {
            a = (j==1?"":a OFS) A[j]/(C[j]==0? 1 : C[j])
            if (C[j] > 1)
                print i
        }
            
        print i "\t" a >> (ARGV[1] ".ave")
        print i "\t" max[i] >> (ARGV[1] ".max")
    }
}


