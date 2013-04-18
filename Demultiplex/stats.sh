#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

lane=$1;
tile=$2;
tagfile=$3;
rowEx=`which selectrows.pl`

forward=s_${lane}_1_${tile}_qseq.txt.gz;
index=s_${lane}_2_${tile}_qseq.txt.gz;
reverse=s_${lane}_3_${tile}_qseq.txt.gz;

qsub -l express `which allStats.sh` $lane $tile 

for tag in `cat ../$tagfile`; do
	zcat $index | cut -f9 | grep -n ^$tag | awk '{split($1,a,":"); print a[1]}' > tagrows_${tile}_${tag}.txt;

	if [ -s $reverse ]; then
		zcat $forward | `which selectrows.pl` tagrows_${tile}_${tag}.txt | awk -v tag=$tag '$11==1 {print "@" $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" $6 ":" $7 ":" $8 "#" tag "/1\n" $9 "\n+\n" $10}' | gzip > ${tag}/s_${lane}_1_${tile}_${tag}.fastq.gz;
		zcat $reverse | `which selectrows.pl` tagrows_${tile}_${tag}.txt | awk -v tag=$tag '$11==1 {print "@" $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" $6 ":" $7 ":" $8 "#" tag "/2\n" $9 "\n+\n" $10}' | gzip > ${tag}/s_${lane}_2_${tile}_${tag}.fastq.gz;
		qsub -l express `which indexStats.sh` $lane $tile $tag 2;
	else
		zcat $forward | `which selectrows.pl` tagrows_${tile}_${tag}.txt | awk -v tag=$tag '$11==1 {print "@" $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" $6 ":" $7 ":" $8 "#" tag "/1\n" $9 "\n+\n" $10}' | gzip > ${tag}/s_${lane}_1_${tile}_${tag}.fastq.gz;
		qsub -l express `which indexStats.sh` $lane $tile $tat 1;
	fi
done


