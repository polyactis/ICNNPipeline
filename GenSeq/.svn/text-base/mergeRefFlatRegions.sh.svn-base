#!/bin/bash - 
#===============================================================================
#
#          FILE:  mergeRefFlatRegions.sh
# 
#         USAGE:  ./mergeRefFlatRegions.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/25/2010 02:16:32 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

awk 'BEGIN{OFS="\t"}{$5=0; print}' $1 |  sort -k 1,1 -k 6,6 -k 4,4 -k 2,2n -k 3,3n | (uniq - ; echo -e chrDummy '\t' 0 '\t' 0 '\t' '\t' geneDummy '\t' 0 '\t' +) |  mergeRefFlatRegions.awk 
