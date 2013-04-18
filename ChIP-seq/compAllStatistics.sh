#!/bin/bash - 
#===============================================================================
#
#          FILE:  mainPipe.sh
# 
#         USAGE:  ./mainPipe.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/02/2010 02:28:15 AM PST
#      REVISION:  ---
#===============================================================================

#$ -cwd
#$ -l h_data=1024M
#$ -pe shared 4

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

alnFile=rmDup.unique.Genomic

totalUniqueAlgn=`awk '$1==1 && $2<=2' algnStat.txt | wc -l`

rmDupUniqForward=`wc -l $alnFile.F.aln | awk '{print $1}'`
rmDupUniqReverse=`wc -l $alnFile.R.aln | awk '{print $1}'`
rmDupUniq=$(($rmDupUniqForward + $rmDupUniqReverse))

promoter=`awk '{ count += $2}END{ print count}' $alnFile.tssBindCount`
genic=`awk '{ count += $2}END{ print count}' $alnFile.geneBindCount`

inRep=`wc -l multi.inRep.Genomic.algn.bed | awk '{print $1}'`

awk '$5==1{ count[$1]++ }END{ for (i in count) print i "\t" count[i] }' Genomic.algn.bed | \
    sortChromData.sh - | cjoin.awk - $refDir/genome.fasta.chromLen > chromHitCount.tsv

# write statistics to tsv file
statFile=sampleStatistics.tsv

printf "aligned_Genome\t%d\n" `wc -l Genomic.algn.bed | awk '{print $1}'` >> $statFile

printf "aligned_repeats\t%d\n" $inRep >> $statFile

printf "aligned_uniquely\t%d\n" $totalUniqueAlgn >> $statFile

printf "rmDup_uniq_forward\t%d\n" $rmDupUniqForward >> $statFile
printf "rmDup_uniq_reverse\t%d\n" $rmDupUniqReverse >> $statFile
printf "rmDup_uniq\t%d\n" $rmDupUniq>> $statFile


printf "rmDup_uniq_promoter\t%d\n" $promoter >> $statFile

cut -f1,2 chromHitCount.tsv >> $statFile


