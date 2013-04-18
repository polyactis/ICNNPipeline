#! /usr/bin/awk -f
{
    for (i=2;i<=NF;i++) {
        sum[$1 i] += $i
    }
    key[$1] = 1
}
END {
    for (i in key) {
        line = i
        for (j=2;j<=NF;j++) {
           line = line "\t" sum[i j] 
        }
        print line
    }
}

