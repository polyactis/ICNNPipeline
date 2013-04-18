#!/bin/bash - 
#===============================================================================
#
#          FILE:  qualityFilter.sh
# 
#         USAGE:  ./qualityFilter.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/04/2010 04:49:37 PM PST
#      REVISION:  ---
#===============================================================================
#$ -cwd

if [ $# -ne 2 ]; then
    echo SYNOPSIS: `basename $0` fastq len
    exit 1
fi
set -o nounset                              # Treat unset variables as an error

fastq=$1
len=$2
~/PIPELINE/GenSeq/qualityFilter.awk -v L=$len $fastq > filtered.`basename $fastq`

