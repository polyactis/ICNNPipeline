#! /usr/bin/awk -f
BEGIN{  OFS="\t" }
{
    start=$2
    end=$3
    if ($6 == "-") {
        $2 = start-1
        $3 = start+1
    }
    else {
        $2 = end-1
        $3 = end+1
    }
    print $0
}
