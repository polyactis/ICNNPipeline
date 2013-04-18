#!/bin/bash - 
#===============================================================================
#
#          FILE:  makeRefFiles.sh
# 
#         USAGE:  ./makeRefFiles.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/28/2010 12:04:51 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if ! [ -f downloaded.refFlat.txt ]; then
    mv refFlat.txt downloaded.refFlat.txt
fi

grep -v "rand\|hap\|chrM\|NR_" downloaded.refFlat.txt > refFlat.txt
awk '{print $3 "\t" $5 "\t" $6 "\t" $1 "\t" $2 "\t" $4}' refFlat.txt > isoform.refFlat.bed

createMetaGeneExonBed.sh isoform.refFlat.bed exonUTR.refFlat.bed
