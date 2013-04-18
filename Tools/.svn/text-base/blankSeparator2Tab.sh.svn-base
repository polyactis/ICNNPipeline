#!/bin/bash - 
#===============================================================================
#
#          FILE:  blankSeparator2Tab.sh
# 
#         USAGE:  ./blankSeparator2Tab.sh 
# 
#   DESCRIPTION: bedtools can only work with tab separator files. This script is to convert arbitrary blank separated files into tab-separated ones
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/26/2010 10:06:09 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

tempFile=`getTempRandName.sh`
sed 's/[ \t]\+/\t/' $1 > $tempFile
mv $tempFile $1
