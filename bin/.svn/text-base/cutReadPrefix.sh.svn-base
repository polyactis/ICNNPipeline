#!/bin/bash - 
#===============================================================================
#
#          FILE:  cutReadPrefix.sh
# 
#         USAGE:  ./cutReadPrefix.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 06/21/2012 01:05:15 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

outDir=$1
length=$2

shift
shift

mkdir -p $outDir

for fastq in $@; do
    cutReadPrefix.awk -v len=$length $fastq > $outDir/`basename $fastq`
done

script_end



