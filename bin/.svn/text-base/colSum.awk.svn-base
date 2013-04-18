#! /usr/bin/awk -f
{
    for (i=1;i<=NF;i++) {
        sum[i] += $i
    }
}
END {
    line = sum[1]
    for (i=2;i<=NF;i++) {
        line = line "\t" sum[i]
    }
    print line
}
