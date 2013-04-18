#!/bin/bash - 
#===============================================================================
#
#          FILE:  fixPound.sh
# 
#         USAGE:  ./fixPound.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/13/2010 09:58:31 AM PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

sed 's/#/\t/g' $1 | awk '{print $1 "\t" $2 "\t" $6 "\t" $7}' > $1.fixed
