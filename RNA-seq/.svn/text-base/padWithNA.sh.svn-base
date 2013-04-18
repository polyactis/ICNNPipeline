#!/bin/bash - 
#===============================================================================
#
#          FILE:  padWithNA.sh
# 
#         USAGE:  ./padWithNA.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/18/2010 10:07:28 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

padWithNA.awk $1 > tempPadded.`basename $1`
mv tempPadded.`basename $1` $1
