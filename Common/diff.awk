#!/usr/bin/awk -f
{
if (FILENAME==ARGV[1]) {
    first[$1] = 1
}
else {
    if (first[$1] != 1)
        print
}
}
