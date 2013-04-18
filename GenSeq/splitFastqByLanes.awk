#! /usr/bin/awk -f 
BEGIN {
    if (flowcell == 0 || lane == 0) {
        print "ERROR: need flowcell and lane field number"
        exit 1
    }
    system("rm -f " ARGV[1] ".flowcell_*_lane*")
}
NR % 4 == 1{
    id = $1
    split(substr(id,2),fields,":")
    outFile = FILENAME ".flowcell_" fields[flowcell] "_lane" fields[lane]
}
NR % 4 == 2{
    seq = $1
}
NR % 4 == 0{
    print id "\n" seq "\n+\n" $1 >> outFile 
}
