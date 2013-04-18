#!/bin/bash - 
#===============================================================================
#
#          FILE:  qsubAllSamplePipes.sh
# 
#         USAGE:  ./qsubAllSamplePipes.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/27/2010 09:32:02 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

for i in `find -L . -name sequence.fastq`; do
    d=`dirname $i`
    d=`dirname $d`
    echo $d
done | sort | uniq > temp.batchDirList

for i in `cat temp.batchDirList`; do
    echo $i
    pushd $i > /dev/null
    qsub  ~/PIPELINE/RNA-seq/batchPipe.sh
    popd > /dev/null
done
rm temp.batchDirList 
