#!/bin/bash - 
#===============================================================================
#
#          FILE:  patch.filterDup.sh
# 
#         USAGE:  ./patch.filterDup.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/02/2010 11:11:19 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd

set -o nounset                              # Treat unset variables as an error

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

refDir=$1
refFlat=$refDir/refFlat.txt
geneBed=$refDir/isoform.refFlat.bed
uniqueAlgnBed=unique.Genomic.algn.bed
alnFile=rmDup.unique.Genomic

echo counting duplicate statistics in unique alignment ...
awk '{print $1 ":" $2 "\t" 1}' $uniqueAlgnBed | aggregate.awk | awk '{print $2 "\t" 1}' | aggregate.awk | sort -k1,1n > duplicateCount.tsv

tssBed=`getTempRandName.sh`.tssRegion.bed

extractTSSregion.awk $refFlat > $tssBed

for i in F R; do
    echo on the $i strand ... 
    if [ $i == "F" ]; then
        strand="+"
    else
        strand="-"
    fi
    echo ... counting reads binding to TSS
    time awk -v strand=$strand '{ print $1 "\t" $2-1 "\t" $2 "\tgeneName\t0\t" strand }' $alnFile.$i.aln | intersectBed -a stdin -b $tssBed -wa -wb | awk '{ print $2-$8-2500 "\t" 1 }' | aggregate.awk | sort -k1,1n > $alnFile.$i.tssBindCount

#    echo ... counting reads binding to gene
#    time awk -v strand=$strand '{ print $1 "\t" $2-1 "\t" $2 "\tgeneName\t0\t" strand }' $alnFile.$i.aln | intersectBed -a stdin -b $geneBed -wa -wb | awk '{ print int(100*($6=="+"?$2-$8:$9-$2)/($9-$8)) "\t" 1 }' | aggregate.awk | sort -k1,1n > $alnFile.$i.geneBindCount

done

rowSum.awk $alnFile.F.tssBindCount $alnFile.R.tssBindCount > $alnFile.tssBindCount
#rowSum.awk $alnFile.F.geneBindCount $alnFile.R.geneBindCount > $alnFile.geneBindCount

rm $tssBed


