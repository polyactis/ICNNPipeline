#!/bin/bash - 
#===============================================================================
#
#          FILE:  compressQseqFiles.sh
# 
#         USAGE:  ./compressQseqFiles.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 10/22/2012 09:02:58 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

for lane in `awk '{print $3}' samples.txt | sed 's/,/\n/g' | sort | uniq`; do 
    for i in 1 2 3; do
        qsub -l time=4:0:0,h_data=4G `which gzipit.sh` `ls L00$lane/s_${lane}_${i}_*_qseq.txt` 
    done
done

script_end




