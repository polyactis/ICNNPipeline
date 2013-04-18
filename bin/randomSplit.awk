#!/bin/awk -f
BEGIN {
    if (length(ARGV)==1 || ARGV[1] == "-") {
        outfile = "stdin"
    }
    else {
        outfile = ARGV[1]
    }
}
{
    k = int(rand()*n)
    print >> sprintf("%s.randomSplit.%d",outfile,k)
}
