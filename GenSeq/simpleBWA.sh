#!/bin/bash - 

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

source error_handling
script_start

if [ $# -ne 2 ]; then
    echo `basename $0` referenceFasta fastq
    exit 1
fi

ref=$1
fq=$2
bwa=bwa
out=`basename $ref`
out=`dirname $ref | xargs basename`_$out
out=`dirname $fq`/`basename $fq .fastq`-$out.bam

baseQ[0]=20
baseQ[1]=53

isILMN=`illuminaPhredScoreRange.sh $fq | awk '{print $2}'`

$bwa aln -q ${baseQ[$isILMN]} $ref $fq | $bwa samse $ref - $fq | tee >(awk '$3 != "*"' | samtools view -Sb -t $ref.fai - > $out) | awk '$3 == "*"' | fastqFromSam.awk | gzip - > `dirname $out`/`basename $out .sam`.unmapped.fastq.gz 


script_end
