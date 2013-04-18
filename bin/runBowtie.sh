#! /bin/bash -f

#$ -V
#$ -cwd
#$ -l h_data=4G
#######$ -l h_rt=04:00:00

if [ $# -ne 2 ]; then
    echo `basename $0` referenceFasta fastq
    exit 1
fi

set -eux

ref=$1
fq=$2
bowtie=/u/home/eeskin/namtran/Experiment/RNA-seq/Freimer/12vervets4tissues/Phylo/bowtie-0.12.7/bowtie
out=`dirname $fq`/`basename $ref`-`basename $fq .fastq`.bowtie.sam

$bowtie -S --sam-nohead -m 1 $ref $fq | awk '$3 != "*"' > $out 



