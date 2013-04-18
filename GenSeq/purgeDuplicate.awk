#! /usr/bin/awk -f
BEGIN {
    while ($3 !~ /chr/) getline
    cur = $2 "#" $3 "#" $4
    curLine = $0
    count = 0
}
{
    suc = $2 "#" $3 "#" $4
    if ( cur != suc ) {
        if ( count == 0) {
            print curLine
        }
        else {
            count = 0
        }
    }
    else {
        count++
    }
    cur = suc; curLine = $0
}
END {
    if (count == 0) print curLine
}
