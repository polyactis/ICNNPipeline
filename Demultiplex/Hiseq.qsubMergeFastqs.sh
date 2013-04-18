#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

fileDir=$1

mkdir -p FASTQs;

ls $fileDir > temp.txt

logDir=`makeLogDir.sh Qsub/mergeFastq`
makeLogDir.sh Qsub/mergeFastq/gzipit

for i in `cat temp.txt`; do 
	qsub -e $logDir -o $logDir `which mergeFastq.sh` $fileDir $i;
done

rm temp.txt;
