#!/usr/bin/awk -f
BEGIN {  FS ="\t"
}
{   print $1 "\n" $2 "\n+\n" $3
}
