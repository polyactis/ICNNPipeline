#!/bin/bash - 

#$ -V
#$ -cwd 

set -e
source error_handling
script_start


sample=$1
tag=$2
lanes=$3

mkdir -p FILES/$sample
cd FILES/$sample;
rm -f *

for lane in `cat ../../$lanes`; do 
	
#	temp=`ls ../../L00${lane}/s_${lane}_1_*_qseq.txt.gz | awk 'NR==1 {split($1,a,"_"); print a[4]}'`;
#	tempreverse=../../L00${lane}/${tag}/s_${lane}_2_${temp}_${tag}.fastq.gz

    [ `ls ../../L00${lane}/${tag}/s_${lane}_1_*.fastq* | wc -l` -gt 0 ] && ln -s ../../L00${lane}/${tag}/s_${lane}_1_*fastq* .
	[ `ls ../../L00${lane}/${tag}/s_${lane}_2_*.fastq* | wc -l` -gt 0 ] && ln -s ../../L00${lane}/${tag}/s_${lane}_2_*fastq* .
#	if [ -s $tempreverse ]; then
#		ln -s ../../L00${lane}/${tag}/s_${lane}_1_* .
#		ln -s ../../L00${lane}/${tag}/s_${lane}_2_* .
#	else
#		ln -s ../../L00${lane}/${tag}/s_${lane}_1_* .
#	fi
done

rm -f ../../$lanes;

script_end

