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

if [ $# -ne 1 ]; then
    echo reference dir needed
    exit
fi

for i in `find -L . -name sequence.fastq`; do
    d=`dirname $i`
    echo $d
    pushd $d > /dev/null
    qsub  ~/PIPELINE/ChIP-seq/samplePipe.sh $1
    popd > /dev/null
done

