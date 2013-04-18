#!/bin/bash - 
#===============================================================================
#
#          FILE:  cleanTesty.sh
# 
#         USAGE:  ./cleanTesty.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/27/2010 12:48:01 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

rm -rf *.png *.xls
for i in `find -L . -type f -name sequence.fastq`; do
    pushd `dirname $i`; 
    mv sequence.fastq sequence;
    mv sample10000.sequence.fastq sample10000
    rm *.*;
    mv sequence sequence.fastq; 
    mv sample10000 sample10000.sequence.fastq
    popd;
done
