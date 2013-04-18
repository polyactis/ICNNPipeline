#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

fileDir=$1

mkdir -p FASTQs;

ls $fileDir > temp.txt

for i in `cat temp.txt`; do 
	qsub `which mergeFastqUncompressed.sh` $fileDir $i;
done

rm temp.txt;
