#!/bin/bash -f 

#$ -V
#$ -cwd 
#$ -l h_data=4096M
#$ -l h_rt=12:00:00

source error_handling.sh 

start_script

echo bwa: `which bwa`
echo sam2bam: `which sam2bam.sh`

ref=$1
fastq=$2

file=`basename $fastq .fastq`
sam=$file.sam
bam=$file.bam

fai=$ref.fai
ls $ref

if [ -f "$fai" ]; then
    bwa aln $ref $fastq | bwa samse $ref - $fastq | tee \
    >(awk '$3 != "*"' | samtools -Sb -t $fai - > $bam) \ 
    >(awk '$3 == "*"' | fastqFromSam.awk > `dirname $fastq`/`basename $fastq .fastq`.unmapped.fastq)
else
    bwa aln $ref $fastq | bwa samse $ref - $fastq | tee \
    >(awk '$3 != "*"' > $sam) \ 
    >(awk '$3 == "*"' | fastqFromSam.awk > `dirname $fastq`/`basename $fastq .fastq`.unmapped.fastq)
fi

end_script
