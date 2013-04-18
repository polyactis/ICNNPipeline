#! /usr/bin/awk -f
BEGIN {
    getline
    chr = $1
    start = $2
    end = $3
    count = 1 
}
{
    if (chr == $1 && $2 < end) {
        count++
        end = $3
    }
    else {
        print chr "\t" start "\t" end "\t" count
        chr = $1
        start = $2
        end = $3
        count = 1 
    }
}
END {
    if (length(chr)) 
        print chr "\t" start "\t" end "\t" count 
}
