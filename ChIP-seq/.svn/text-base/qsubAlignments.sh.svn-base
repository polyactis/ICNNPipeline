#!/bin/bash - 
#===============================================================================
#
#          FILE:  qsubAlignments.sh
# 
#         USAGE:  ./qsubAlignments.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/28/2010 11:41:30 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo refDir needed
    exit
fi

refDir=$1

for i in `find . -name "*.fastq"`; do
    d=`dirname $i`
    f=`basename $i .fastq`
    q=$f.fastq
    pushd $d > /dev/null
    echo processing $q in $d
#    qsub ~/PIPELINE/bin/randomFastq.sh $q 10000
    ~/pipeline/run.sh BWA $refDir/genome.fasta `pwd`/$q $f     
    popd > /dev/null
done


    
