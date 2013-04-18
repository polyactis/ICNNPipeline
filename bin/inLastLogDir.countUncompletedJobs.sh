#!/bin/bash - 
#===============================================================================
#
#          FILE:  inLastLogDir.countUncompletedJobs.sh
# 
#         USAGE:  ./inLastLogDir.countUncompletedJobs.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 12/23/2011 01:24:07 PM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

d=$1
L=`ls -l $d/Log | awk '{print $NF}'`
countUncompletedJobs.sh $d/$L/*.sh.e*
