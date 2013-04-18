#!/bin/bash - 
#===============================================================================
#
#          FILE:  mysub.sh
# 
#         USAGE:  ./mysub.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 10/31/2012 01:24:47 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

script=$1

shift

logDir=`basename $script | xargs -I{} makeLogDir.sh Qsub/{}`

qsub -e $logDir -o $logDir $script $@

script_end




