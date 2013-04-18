#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

sample=$1
tag=$2
lanes=$3

mkdir -p FILES/$sample
cd FILES/$sample;

for lane in `cat ../../$lanes`; do 
	
#	temp=`ls ../../L00${lane}/s_${lane}_1_*_qseq.txt.gz | awk 'NR==1 {split($1,a,"_"); print a[4]}'`;
#	tempreverse=../../L00${lane}/${tag}/s_${lane}_2_${temp}_${tag}.fastq.gz

	ln -s ../../L00${lane}/${tag}/s_${lane}_1_* .
#	ln -s ../../L00${lane}/${tag}/s_${lane}_2_* .
#	if [ -s $tempreverse ]; then
#		ln -s ../../L00${lane}/${tag}/s_${lane}_1_* .
#		ln -s ../../L00${lane}/${tag}/s_${lane}_2_* .
#	else
#		ln -s ../../L00${lane}/${tag}/s_${lane}_1_* .
#	fi
done

###NT: not removed for debugginh
###rm -f ../../$lanes;

