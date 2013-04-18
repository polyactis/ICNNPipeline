#! /usr/bin/awk -f
{
    if (FILENAME == ARGV[1] ) {
        row[$1] = $0
        field[NR] = $1
    }
    else {
        for (i=2; i <= NF; i++) 
            row[$1] = row[$1] "\t" $i
    }
}
END {
    for (i=1; i <= length(field); i++) 
        print row[field[i]]
}
