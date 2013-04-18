#!/usr/bin/awk -f
{
    line = $0;
    for (i=NF+1;i<=100;i++) {
        line = line " NA"
    }
    print line
}
