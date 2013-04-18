#!/bin/bash - 
#===============================================================================
#
#          FILE:  removeLogsOfSuspendedJobs.sh
# 
#         USAGE:  ./removeLogsOfSuspendedJobs.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 12/21/2011 11:16:45 AM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

tempFile=/u/scratch/namtran/`getTempRandName.sh`

for j in $@; do
    qstat -j $j > $tempFile
    script=`grep -m1 job_name: $tempFile | awk '{print $NF}' | awk -F: '{print $NF}'`
    epath=`grep -m1 stderr_path_list: $tempFile | awk '{print $NF}' | awk -F: '{print $NF}'`
    opath=`grep -m1 stdout_path_list: $tempFile | awk '{print $NF}' | awk -F: '{print $NF}'`
    rm -f $tempFile
    if [ `ls $epath/$script.e$j $opath/$script.o$j | wc -l` == 2 ]; then
        for f in $epath/$script.e$j $opath/$script.o$j; do
            test -f $f && rm $f
        done
    fi
done

script_end




