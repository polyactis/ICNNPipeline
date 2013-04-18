#!/usr/bin/awk -f
{
if (FILENAME==ARGV[1]) {
    first[$1] = $0
}
else {
    if (first[$1] != "" ) {
        key = $1
        $1 = ""
        print first[key] $0
    }
}
}
