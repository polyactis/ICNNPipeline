#!/usr/bin/awk -f
{   
    for(i=1;i<=NF;i++)  {
        c[NR i] = $i 
    }
}
END {
    for(i=1;i<=NF;i++) {
        line = c[1 i]
        for(j=2;j<=NR;j++) {
            line = line "\t" c[j i]
        }
        print line
    }
}
