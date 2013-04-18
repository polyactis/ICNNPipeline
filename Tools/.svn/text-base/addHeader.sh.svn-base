#!/bin/bash - 
#===============================================================================
#
#          FILE:  addHeader.sh
# 
#         USAGE:  ./addHeader.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/06/2010 08:06:26 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -lt 2 ]; then
    echo SYNOPSIS `basename $0` fileName headerFied1 ...
    exit
fi
    
file=$1
if ! [ -f "$file" ]; then
    echo file $file does not exist
    exit
fi

shift

format="%s"
for i in `seq 2 $#`; do
    format="$format\t%s"
done

tempFile=`dirname $file`/`echo | ~/PIPELINE/Tools/getTempRandName.awk`.`basename $file`
printf "$format\n" $@ > $tempFile

cat $file >> $tempFile
mv $tempFile $file
