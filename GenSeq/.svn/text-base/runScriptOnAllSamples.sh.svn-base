#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error

for i in `find -L . -maxdepth 2 \( -type f -name Genomic.algn.bam.bai -or -type d -name Genomic \) -printf "%h\n" | sort | uniq`; do
    pushd $i > /dev/null
    echo working in `pwd`
    $@
    popd > /dev/null
done
