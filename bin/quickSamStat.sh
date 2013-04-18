#!/bin/bash - 
#===============================================================================
#
#          FILE:  quickSamStat.sh
# 
#         USAGE:  ./quickSamStat.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 01/17/2013 11:56:05 AM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

sam=$1
i=`basename $sam`

#opt=""

#[ `basename $sam | grep -c "\.sam$"` -eq 1 ] && opt="-S"

cat $sam | awk '$5>0{ nmap++; nwid+=$6~/[ID]/}END{ print "'$i'\tnprobes\t" NR; print "'$i'\tmapable\t" nmap; print "'$i'\twithIndels\t" nwid}' 
cat $sam | awk '$5>0 && $6!~/[ID]/' | alignmentSam2ProbeBed.awk | awk '{ nunique +=$5==1; nmis[$7]++}END{for (i=0;i<=3;i++) print "'$i'\tnmis_" i "\t" nmis[i]+0; print "'$i'\t nunique\t" nunique}'

script_end




