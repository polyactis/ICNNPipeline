#!/bin/bash
#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

source error_handling
script_start


bam=$1
temp=`dirname $bam`/`basename $bam .bam`.`getTempRandName.sh`

echo sorting $1 ...

rm -f $temp.sorted.bam
samtools sort -m 4000000000 $bam $temp.sorted

mv $temp.sorted.bam $bam

echo indexing ...

samtools index $bam

script_end
