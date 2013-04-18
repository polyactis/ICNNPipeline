#!/bin/bash - 
#===============================================================================
#
#          FILE:  patch.1.sh
# 
#         USAGE:  ./patch.1.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/05/2010 02:37:22 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

refDir=$1
filterDup.sh $refDir
compAllStatistics.sh $refDir
