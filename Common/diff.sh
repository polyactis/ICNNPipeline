#!/bin/bash - 
#===============================================================================
#
#          FILE:  diff.sh
# 
#         USAGE:  ./diff.sh 
# 
#   DESCRIPTION:  find rows of the first file which is not in the second file
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 02/27/2010 05:24:57 PM PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
if [ $# -ne 2 ]; then
    echo SYNOPSIS `basename $0` firstFile secondFile
fi
`which $0 | sed 's/\.sh/.awk/'` $1 $2


