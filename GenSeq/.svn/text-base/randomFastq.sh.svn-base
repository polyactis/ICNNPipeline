#!/bin/bash - 
#===============================================================================
#
#          FILE:  randomFastq.sh
# 
#         USAGE:  ./randomFastq.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 08/20/2012 10:03:37 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

fastq=$1
#total=`awk 'BEGIN{ RS="@" } END{ print NR-1}' $fastq`
#echo total fastq record: $total
nsample=$2
echo number of random records: $nsample

outDir=`dirname $fastq`

[ $# -eq 3 ] && outDir=$3 

~/PIPELINE/bin/randomFastq.awk -v nsample=$nsample $fastq > $outDir/sample$2.`basename $fastq`


script_end

    
