#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

lane=$1;
tile=$2;
tagfile=$3;

forward=s_${lane}_1_${tile}_qseq.txt.gz;
index=s_${lane}_2_${tile}_qseq.txt.gz;

for tag in `cat ../$tagfile`; do
	zcat $index | cut -f9 | grep -n ^$tag | awk '{split($1,a,":"); print a[1]}' > tagrows_${tile}_${tag}.txt;
	zcat $forward | `which selectrows.pl` tagrows_${tile}_${tag}.txt | gzip > ${tag}/s_${lane}_1_${tile}_${tag}.qseq.gz;
done

