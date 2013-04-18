#!/usr/bin/awk -f
BEGIN{
    OFS = "\t"
}
{
    if (FILENAME == ARGV[1] ) {
        gene[$2 $4 $3] = $1
    }
    else {
        $1 = gene[$1 $5 $2]
        if ( $1 ~ /[^\s]/ )
            print $0
    }
}
