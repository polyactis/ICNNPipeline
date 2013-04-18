#!/bin/bash - 
#===============================================================================
#
#          FILE:  randomSplit.sh
# 
#         USAGE:  ./randomSplit.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 02/28/2012 11:30:09 AM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

n=$1

input="-"
[ $# -eq 2 ] && input=$2

randomSplit.awk -v n=$n $input

script_end




