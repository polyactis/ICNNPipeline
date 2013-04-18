#!/bin/bash - 
#===============================================================================
#
#          FILE:  geneExonJunctionMap.sh
# 
#         USAGE:  ./geneExonJunctionMap.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/17/2010 10:12:49 AM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1

geneExonMap=$refDir/geneExonMap.refFlat.bed

awk '{print $1}' junction.coverage | sed 's/\(.*\)\([-+]\)\(chr.*\)#[-+]chr.*:\([0-9]*\)-\([0-9]*\)#[-+]chr.*:\([0-9]*\)-\(.*\)/\3\t\4\t\5\t\0/' > firstExon.junction.bed
awk '{print $1}' junction.coverage | sed 's/\(.*\)\([-+]\)\(chr.*\)#[-+]chr.*:\([0-9]*\)-\([0-9]*\)#[-+]chr.*:\([0-9]*\)-\(.*\)/\3\t\6\t\7\t\0/' > secondExon.junction.bed

intersectBed -a $geneExonMap -b firstExon.junction.bed  -wa -wb | awk -v gap=50 '$8-$2<=gap && $2-$8<=gap && $9-$3<=gap && $3-$9<=gap {print $10 "$" $4}' > gene.firstExon.junction.bed
intersectBed -a $geneExonMap -b secondExon.junction.bed  -wa -wb | awk -v gap=50 '$8-$2<=gap && $2-$8<=gap && $9-$3<=gap && $3-$9<=gap {print $10 "$" $4}' > gene.secondExon.junction.bed

insect.awk gene.firstExon.junction.bed gene.secondExon.junction.bed | awk -F"$" '{print $2 "\t" $1}' > geneJunctionMap.tsv

rm firstExon.junction.bed secondExon.junction.bed gene.firstExon.junction.bed gene.secondExon.junction.bed
