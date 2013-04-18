#!/bin/bash - 
#===============================================================================
#
#          FILE:  getTempRandName.sh
# 
#         USAGE:  ./getTempRandName.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/08/2010 12:59:09 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo `echo | getTempRandName.awk -v procid=$$``echo $@ | sed -e 's/[^a-zA-Z]*//g'`
