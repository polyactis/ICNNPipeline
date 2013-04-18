#!/bin/bash - 
#===============================================================================
#
#          FILE:  annotPeak2ndCod.sh
# 
#         USAGE:  ./annotPeak2ndCod.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/23/2010 08:03:45 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

ref=~/Data/RefGenome/Mouse/mm9/gene.refFlat.bed

intersectBed -a $1 -b $ref -wa -wb | awk '{ print $1 "\t" $2 "\t" $3 "\t" $5 "\t" $7 "\t" $21}' | sort -nk 4,4 > $1.annot
