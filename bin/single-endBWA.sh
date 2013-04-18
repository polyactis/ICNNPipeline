#! /bin/bash -f


#$ -V
#$ -cwd
#$ -l h_data=4G

if [ $# -ne 3 ]; then
    echo `basename $0` referenceFasta fastq baseQ
    exit 1
fi

set -eux

ref=$1
fq=$2
baseQ=$3

bwa=bwa
out=`basename $ref`
out=`dirname $ref | xargs basename`_$out
out=`dirname $fq`/`basename $fq .fastq`-$out.sam

$bwa aln -q $baseQ $ref $fq | $bwa samse $ref - $fq | tee >(awk '$3 != "*"' > $out) | awk '$3 == "*"' | fastqFromSam.awk > `basename $ref`-`basename $fq .fastq`.unmapped.fastq
