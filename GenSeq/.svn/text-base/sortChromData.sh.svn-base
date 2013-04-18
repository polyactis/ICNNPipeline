#!/bin/bash - 
#===============================================================================
#
#          FILE:  sortChromData.sh
# 
#         USAGE:  ./sortChromData.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/19/2010 05:42:51 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

tempFile=`getTempRandName.sh`
sleep 1
temp2=`getTempRandName.sh`

cat $1 > $tempFile

for i in `seq 1 100` X Y M; do 
    grep "chr$i[^0-9]" $tempFile | sort -k1
    grep -v "chr$i[^0-9]" $tempFile > $temp2
    mv $temp2 $tempFile
done

cat $tempFile | sort


