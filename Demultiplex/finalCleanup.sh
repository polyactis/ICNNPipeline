#!/bin/bash - 
#===============================================================================
#
#          FILE:  finalCleanup.sh
# 
#         USAGE:  ./finalCleanup.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 11/02/2012 10:55:16 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

pushd $1

nsample=`cut -d' ' -f1 samples.txt | sort -u | wc -l`

if [ `ls FILES | wc -l` -ne $nsample ] || [ `countJobs.sh x Qsub/mergeFastq/Log/mergeFastq.sh.e* | grep -c "$nsample 1"` -ne 1 ] || [ `countJobs.sh x Qsub/mergeFastq/gzipit/Log/gzipit.sh.e* | xargs echo | awk '{ print (NF==2 && $2==1)}'` -ne 1 ] ; then
    echo ERROR merging or gzipping had problem 2>&1
    echo Stop or Continue?
    read d
    [ $d == "S" ] || [ $d != "C" ] && exit 1
fi

find L00* -maxdepth 2 -type f -name *.fastq -delete 

rm -rf FILES

popd 
script_end




