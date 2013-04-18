#!/usr/bin/awk -f
{
    if (FILENAME == ARGV[1]) { # gene with total exon length
        total[$1] = 0
        len[$1] = $2
    }
    else {
        if ( len[$1] != 0 )
            total[$1] += $2
    }
}
END {
    for (i in total) {
        print i "\t" total[i] "\t" len[i]
    }
}

