#!/usr/bin/awk -f
BEGIN{
    split(cols,C)
}
{
    line = $C[1] 
    for (i=2; i <= length(C); i++) {
        line = line "\t" $C[i]
    }
    print line
}
