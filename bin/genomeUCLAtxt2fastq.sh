#!/bin/bash - 
#===============================================================================
#
#          FILE:  genomeUCLAtxt2fastq.sh
# 
#         USAGE:  ./genomeUCLAtxt2fastq.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/22/2010 11:44:37 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd

set -o nounset                              # Treat unset variables as an error

fastq=$1.fastq

> $fastq

for i in `cat $1` ; do
     awk '{ print "@" $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" $6 ":" $7 ":" $8 ":" $11; print $9 "\n+"; print $10}' $i >> $fastq
done
~/PIPELINE/bin/Nullify.sh $fastq 66
~/PIPELINE/bin/Nullify.sh $fastq 84

for i in 66 84; do
    ~/PIPELINE/bin/randomFastq.sh $fastq 10000
    ~/PIPELINE/bin/randomFastq.sh $1.VarTrim66.fastq 10000
    ~/PIPELINE/bin/randomFastq.sh $1.VarTrim84.fastq 10000
done

