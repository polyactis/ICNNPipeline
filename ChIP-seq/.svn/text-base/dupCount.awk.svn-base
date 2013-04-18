#! /usr/bin/awk -f
BEGIN {
    getline
    count = 1
    prev = $0
}
{   
    if ($0 == prev) {
        count++
    }
    else {
        dup[count]++
        count = 1
        prev = $0
    }
}
END {
    dup[count]++
    for (i in dup) {
        print i "\t" dup[i]
    }
}
