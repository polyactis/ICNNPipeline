#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

fileDir=$1

mkdir -p QSEQ;

ls $fileDir > temp.txt

for i in `cat temp.txt`; do 
	qsub `which mergeFastq2.sh` $fileDir $i;
done

rm temp.txt;
