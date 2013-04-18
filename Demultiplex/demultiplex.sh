#!/bin/bash - 

#$ -V
#$ -cwd 

set -e
source error_handling
script_start


lane=$1;
tile=$2;
tagfile=$3;

forward=s_${lane}_1_${tile}_qseq.txt;
index=s_${lane}_2_${tile}_qseq.txt;
reverse=s_${lane}_3_${tile}_qseq.txt;

for tag in `cat ../$tagfile`; do
	cat $index | cut -f9 | grep -n ^$tag | awk '{split($1,a,":"); print a[1]}' > tagrows_${tile}_${tag}.txt;

	if [ -s $reverse ]; then
		cat $forward | `which selectrows.pl` tagrows_${tile}_${tag}.txt | awk -v tag=$tag '$11==1 {print "@" $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" $6 ":" $7 ":" $8 "#" tag "/1\n" $9 "\n+\n" $10}' | gzip > ${tag}/s_${lane}_1_${tile}_${tag}.fastq.gz;
		cat $reverse | `which selectrows.pl` tagrows_${tile}_${tag}.txt | awk -v tag=$tag '$11==1 {print "@" $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" $6 ":" $7 ":" $8 "#" tag "/2\n" $9 "\n+\n" $10}' | gzip > ${tag}/s_${lane}_2_${tile}_${tag}.fastq.gz;
		rm -f tagrows_${tile}_${tag}.txt;
	else
		cat $forward | `which selectrows.pl` tagrows_${tile}_${tag}.txt | awk -v tag=$tag '$11==1 {print "@" $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" $6 ":" $7 ":" $8 "#" tag "/1\n" $9 "\n+\n" $10}' | gzip > ${tag}/s_${lane}_1_${tile}_${tag}.fastq.gz;
		rm tagrows_${tile}_${tag}.txt;
	fi
done



script_end




