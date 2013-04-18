#!/bin/bash - 
#===============================================================================
#
#          FILE:  checkPairedFiles.sh
# 
#         USAGE:  ./checkPairedFiles.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 08/28/2012 01:00:30 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

first=$1
second=`dirname $first`/`basename $first | sed 's/_1.fastq/_2.fastq/'`

catCmd=cat
[ `basename $first | grep -c .fastq.gz$` -eq 1 ] && catCmd=zcat

nlineDif=1

[ -f $first -a -f $second ] && nlineDif=`$catCmd $first | awk 'NR%4==1{print}' | cut -d/ -f1 | sed 's/:[13]#/#/' | paste - <($catCmd $second | awk 'NR%4==1{print}' | cut -d/ -f1 | sed 's/:[13]#/#/') | awk '$1 != $2' | wc -l`

echo $first $second $nlineDif

script_end
