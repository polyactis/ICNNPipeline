#! /usr/bin/awk -f
{
    if (FILENAME == ARGV[1]) {
        key[NR] = $1
    }
    for (i=2; i<=NF; i++) {
        sum[$1 "\t" i] += $i
    }
}
END {
    for (r=1; r <= length(key); r++) {
        line = key[r]
        for (i=2; i<=NF; i++) {
            line = line "\t" sum[key[r] "\t" i] 
        }
        print line
    }
}
