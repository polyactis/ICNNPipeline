#!/usr/bin/awk -f
BEGIN{
    RS = ">"
    FS = "\n"
    getline
}
{
    line = ">" $1 "\t"
    for (i=2; i<NF; i++)
        line = line $i

    print line
}
