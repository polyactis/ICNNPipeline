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
set -o nounset                              # Treat unset variables as an error


if [ $# -ne 1 ]; then
    echo reference dir needed
    exit
fi

refDir=$1

for i in control experiment; do
#    qsub ~/PIPELINE/bin/randomFastq.sh `pwd`/$i.fastq 10000
#    qsub ~/PIPELINE/bin/randomFastq.sh `pwd`/non-filtered.$i.fastq 10000
#    ~/pipeline/run.sh BWA $refDir/genome.fasta `pwd`/$i.fastq $i

done
