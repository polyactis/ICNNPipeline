#!/bin/bash - 
#===============================================================================
#
#          FILE:  getIntervalFromFasta.sh
# 
#         USAGE:  ./getIntervalFromFasta.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/12/2010 02:03:59 PM PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

grep -o "range=chr[0-9MXY]*:[0-9]*-[0-9]*" $1 | sed 's/range=\(chr.*\):\([0-9]\+\)-\([0-9]\+\)/\1\t\2\t\3/' | sort | uniq | awk '{print $1 "\t" $2-1 "\t" $3}'
