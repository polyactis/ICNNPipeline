#! /usr/bin/awk -f
{
    if (!exist[$1]) { 
        exist[$1] = 1
        rowname[length(rowname)+1] = $1
    }
    for (j=2;j<=NF;j++) {
        sum[$1 " " j] += $j    
    }
}
END {
    for (i=1;i<=length(rowname);i++) {
        row = rowname[i] 
        for (j=2;j<=NF;j++) {
            row = row "\t" sum[rowname[i] " " j]
        }
        print row
    }
}
