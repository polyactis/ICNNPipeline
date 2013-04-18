#!/bin/bash - 
#===============================================================================
#
#          FILE:  getChromLength.sh
# 
#         USAGE:  ./getChromLength.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/19/2010 04:55:06 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error

~/PIPELINE/GenSeq/getChromLength.awk $1 > $1.chromLen
