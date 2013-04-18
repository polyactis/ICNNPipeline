#!/bin/bash - 
#===============================================================================
#
#          FILE:  removeDupFromUniqueHits.sh
# 
#         USAGE:  ./removeDupFromUniqueHits.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/07/2010 05:17:45 AM PST
#      REVISION:  ---
#===============================================================================

#$ -cwd
#$ -l h_data=1024M
#$ -pe shared 4 

set -o nounset                              # Treat unset variables as an error
if [ $# -ne 2 ]; then
    echo SYNOPSYS `basename $0` fai bam
    exit 1
fi
ST=~/local/samtools/samtools
ref=$1
bam=$2
sam=`basename $bam .bam`.rmDupUnique.sam

$ST view $bam | awk '$14 == "X0:i:1" && $15 == "X1:i:0"' | ~/PIPELINE/GenSeq/purgeDuplicate.awk > $sam
~/PIPELINE/GenSeq/sam2bam.sh $ref $sam



