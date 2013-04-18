#!/bin/bash - 
#===============================================================================
#
#          FILE:  verifyAlignmentJobs.sh
# 
#         USAGE:  ./verifyAlignmentJobs.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 12/10/2011 09:00:22 PM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

#set -e
#source error_handling
#script_start

set -u
scriptName=$1

out=count.DONE.$scriptName.txt

echo checking log files $scriptName.e ... >&2

for i in `find -L . -maxdepth 4 -name "$scriptName.e*"`; do tail -2 $i | grep -c "^DONE" | xargs echo $i; done | tee >(awk '$2==0' > $out) | awk -F"[ /]" '{print $3 " " $NF}' | sort | uniq -c >&2

echo counting BAMs without indexes ... >&2
find -L . -maxdepth 4 -name "sequence.part*.bam" | awk '{print $0 ".bai"}' | diff.awk - <(find -L . -maxdepth 4 -name "sequence.part*.bam.bai") | tee >(sed 's/.bai$//' > sequence.part.withoutIndex.txt) | wc -l | xargs echo number of BAMs without index: >&2


#script_end
