#!/bin/bash - 
#===============================================================================
#
#          FILE:  fixSampleStatistics.sh
# 
#         USAGE:  ./fixSampleStatistics.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/19/2010 08:21:55 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi
tempFile=`getTempRandName.sh`

statFile=sampleStatistics.tsv
printf "count\t%s\n" `basename $PWD` > $tempFile

grep -m 1 inputSequence $statFile >> $tempFile

mv $tempFile $statFile

~/PIPELINE/ChIP-seq/compAllStatistics.sh $refDir
