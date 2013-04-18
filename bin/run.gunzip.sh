#!/bin/bash - 
#===============================================================================
#
#          FILE:  qsub.gunzip.sh
# 
#         USAGE:  ./qsub.gunzip.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 04/30/2012 07:37:22 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

in=$1
out=$2

mkdir -p `dirname $out`

gunzip -c $in > $out

script_end




