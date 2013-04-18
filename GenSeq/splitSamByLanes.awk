#! /usr/bin/awk -f 
BEGIN {
    if (flowcell == 0 || lane == 0) {
        print "ERROR: need flowcell and lane field number"
        exit 1
    }
    system("rm -f " ARGV[1] ".flowcell_*_lane*")
    if (filename == "") filename = ARGV[1]
    getline
    while ( $1 ~ /^@/ ) {
        getline
    }
    printOneLine()
}
{
    printOneLine()
}
function printOneLine () {
    id = $1
    split(id,fields,":")
    outFile = filename ".flowcell_" fields[flowcell] "_lane" fields[lane]
    print >> outFile 
}
