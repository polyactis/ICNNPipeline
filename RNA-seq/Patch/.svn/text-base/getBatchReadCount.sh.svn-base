#!/bin/bash - 
#===============================================================================
#
#          FILE:  getBatchReadCount.sh
# 
#         USAGE:  ./getBatchReadCount.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/06/2010 09:07:06 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

list=`find -L . -name sequence.fastq | sed 's/sequence.fastq/combinedReadCount.tsv/g'`
nsample=`find -L . -name sequence.fastq | wc -l`
ncol=$((2*nsample))
cjoin.awk $list | cpick.awk -v cols="1 3 `seq 2 2 $ncol`" | sed 's/:/\t/g' > isofReadCount.xls
sampleList=""
for i in `find -L . -name sequence.fastq`; do
    sample=`dirname $i`; sample=`basename $sample`
    sampleList="$sampleList $sample"
done
addHeader.sh isofReadCount.xls gene refseq chrom strand recNum txLen $sampleList

list=`find -L . -name sequence.fastq | sed 's/sequence.fastq/meta.combinedReadCount.tsv/'`
cjoin.awk $list |  cpick.awk -v cols="1 3 `seq 2 2 $ncol`" > metaReadCount.xls
addHeader.sh metaReadCount.xls gene txLen $sampleList


