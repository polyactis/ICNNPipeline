#!/bin/bash -

#$ -cwd

if [ $# -ne 1 ]; then
    echo $0 qseq
    exit 1
fi
qseq=$1
fq=`dirname $qseq`/`basename $qseq _qseq.txt`.fastq

awk '$NF==1 && $(NF-1) !~/^B+$/' $qseq | sed -e 's/\./N/g' -e 's/\t/:/g' | sed 's/\(.*\):\([^:]*\):\([^:]*\):\([^:]*\)$/@\1:\4\n\2\n+\n\3/' > $fq
