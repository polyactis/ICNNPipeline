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
    cp ~/PIPELINE/RNA-seq/report.tex . 
    for i in *.png; do
        convert $i `basename $i .png`.eps
    done
    latex report.tex
    dvipdfm -p letter -l report.dvi
    rm -rf Results
    mkdir Results
    cp *.png report.pdf isofRPKM.xls metaRPKM.xls allStatistics.xls isofReadCount.xls metaReadCount.xls Results
    popd > /dev/null
done
