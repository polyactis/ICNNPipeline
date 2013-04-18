#!/bin/bash - 
#===============================================================================
#
#          FILE:  tryAbsolutePath.sh
# 
#         USAGE:  ./tryAbsolutePath.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 12/14/2011 11:27:19 AM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

resubLog=$1
echo checking if $resubLog is a absolute path ...
dummy=tmp.`getTempRandName.sh`
mkdir $dummy
pushd $dummy > /dev/null
ls -d $resubLog
popd > /dev/null
rmdir $dummy



script_end




