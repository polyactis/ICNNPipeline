#! /usr/bin/awk -f
BEGIN {
    code["A"] = "A"
    code["C"] = "C"
    code["G"] = "G"
    code["T"] = "T"
    code["M"] = "AC"
    code["R"] = "AG"
    code["W"] = "AT"
    code["S"] = "CG"
    code["Y"] = "CT"
    code["K"] = "GT"
    OFS = "\t"
}
$(NF-1) !~ /[+\-]/ {
    support=""
    ref = toupper($3)
    site = toupper($4)
    bases = toupper($9)
    gsub(/[,\.]/,ref,bases)
    split(bases,baseArray,"")

    alleleList = code[site]
    if (length(code[site])==1 && site != ref) {
        alleleList = alleleList ref
    }
    for (i=1;i<=length(alleleList);i++) {
        count=0
        allele = substr(alleleList,i,1)
        for(j=1;j<=length(baseArray);j++) {
            count += (baseArray[j] == allele )
        }
        if (count>0) {
            support = support count allele
        }
    }
        
    if ( length(support) > 0 ) {
        $9 = support
    }
    NF = 9
    $3 = ref
    $4 = site
    print
}
