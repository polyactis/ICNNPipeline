#!/bin/bash - 
#===============================================================================
#
#          FILE:  qsubManyAlignments.sh
# 
#         USAGE:  ./qsubManyAlignments.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/28/2010 08:12:12 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd 
#$ -V
set -eux


if [ $# -ne 1 ]; then
    echo reference dir needed
    echo Example: ~/Data/RefGenome/RNA-seq/Human/hg19
    exit 1
fi

for i in *fastq; do d=`basename $i .fastq`; mkdir $d; cd $d; ln -s ../`basename $i` sequence.fastq; cd -; done

refDir=$1

ln -sf $refDir REFERENCE

for i in `find -L . -name sequence.fastq`; do
    d=`dirname $i`
    echo changing to $d ...
    pushd $d > /dev/null
    echo $refDir > input.params
#    qsub ~/PIPELINE/bin/randomFastq.sh `pwd`/sequence.fastq 10000
    ~/pipeline/run.sh $refDir/genome.fasta `pwd`/sequence.fastq Genomic
    ~/pipeline/run.sh $refDir/rRNA.fasta `pwd`/sequence.fastq rRNA
    ~/pipeline/run.sh $refDir/spliceJunction.fasta `pwd`/sequence.fastq Refseq
    popd > /dev/null
done


