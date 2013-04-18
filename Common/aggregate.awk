#!/usr/bin/awk -f
{
    total[$1] += $2
    count[$1]++
}
END{
    for (i in total) {
        print i "\t" total[i] "\t" count[i]
    }
}
