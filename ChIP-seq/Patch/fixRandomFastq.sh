#!/bin/bash - 
#===============================================================================
#
#          FILE:  fixRandomFastq.sh
# 
#         USAGE:  ./fixRandomFastq.sh 
# 
#   DESCRIPTION: when extract fastq from sam, need to reverse complement 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/14/2010 04:02:13 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error


if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

# for plotting quality
nsample=10000
nRead=`samtools view Genomic.algn.bam | wc -l`
sampleFastq=sample$nsample.sequence.fastq
samtools view Genomic.algn.bam | randomLines.awk -v nsample=$nsample -v total=$nRead | fastqFromSam.awk > $sampleFastq 
fastq2number.sh $sampleFastq

