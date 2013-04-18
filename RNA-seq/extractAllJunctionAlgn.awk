#! /usr/bin/awk -f
BEGIN{
#    readLen = 0; 
#    if ( length(ARGV) > 1 ) {
#        cmd = "head -1 " ARGV[1] " | awk '{print length($10)}' "
#        cmd | getline readLen
#    }
}
$3 !~/^\*$/{
    split($3,A,/#/)
    sub(/^[+-]*chr/,"chr",A[2])
    sub(/^[+-]*chr/,"chr",A[3])
    split(A[2],first,/:|-/)
    split(A[3],second,/:|-/)

#   readLen = readLen == 0?length($10):readLen
    readLen = length($10)
    inFirst = (first[3]-first[2]+1) - ($4-1)

# if aligned to junction
    if (1 <= inFirst && inFirst < readLen) {            
        print
    }
}
