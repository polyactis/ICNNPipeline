#! /usr/bin/awk -f
{
    L = $1 "\t" $2
    loc[$4] = L
    count[L]++
}
END {
    for (i in loc) {
        if (count[loc[i]] - minDupCount > 0) {
            print i "\t" count[loc[i]] "\t" loc[i]
        }
    }
}
