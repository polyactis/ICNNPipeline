#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error

tempFile=`getTempRandName.sh`

for i in `find -L . \( -type f -name Genomic.algn.bam.bai -or -type d -name Genomic \) -printf "%h\n" | sort | uniq`; do
    dirname $i
done | sort | uniq > $tempFile

for d in `cat $tempFile`; do
    pushd $d > /dev/null
    echo working in `pwd`
    $@
    popd > /dev/null
done
