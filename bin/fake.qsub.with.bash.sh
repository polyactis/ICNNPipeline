#!/bin/bash - 
#===============================================================================
#
#          FILE:  fake.qsub.with.bash.sh
# 
#         USAGE:  ./fake.qsub.with.bash.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 08/31/2012 02:01:11 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

bash `echo "$@" | sed 's/\(^\| \)-[^ ]\+ [^ \-][^ ]*//g'`

script_end
