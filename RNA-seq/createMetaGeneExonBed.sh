#!/bin/bash - 
#===============================================================================
#
#          FILE:  createMetaGeneExonBed.sh
# 
#         USAGE:  ./createMetaGeneExonBed.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/27/2010 08:33:07 AM PDT
#      REVISION:  ---
#===============================================================================

set -eux

geneBed=$1
exonBed=$2
tempMetaGene=`getTempRandName.sh``basename $geneBed`
metaGeneBed=`dirname $geneBed`/meta.`basename $geneBed`
metaExonBed=`dirname $geneBed`/meta.`basename $exonBed`

mergeRefFlatRegions.sh $geneBed | awk 'BEGIN{OFS="\t"}{ count[$4]++; print $0 "\t" count[$4] }' > $tempMetaGene

# intersect exons and annotate with meta-gene ids, then merge exons of the same meta-gene if overlapping
echo merging exons of the same meta-gene
intersectBed -a $exonBed -b $tempMetaGene -wa -wb | awk '$4==$10{print $1 "\t" $2 "\t" $3 "\t" ($13==1?$4:$4 "_" $13) "\t" 0 "\t" $6}' | mergeRefFlatRegions.sh - > $metaExonBed

# make meta-gene name uniq
echo making meta-gene name unique ...
awk 'BEGIN{OFS="\t"}{ if ($7 > 1) $4 = $4 "_" $7; print}' $tempMetaGene | cut -f1-6 > $metaGeneBed

rm $tempMetaGene
