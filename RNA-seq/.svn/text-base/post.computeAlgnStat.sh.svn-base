#!/bin/bash - 
#===============================================================================
#
#          FILE:  post.computeAlgnStat.sh
# 
#         USAGE:  ./post.computeAlgnStat.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/30/2010 10:18:37 PM PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# put statistics in tsv file
statFile=allStatistics.tsv
printf "variable\t%s\n" `basename $PWD` >$statFile

r=`ls -lL sample10000.sequence.fastq | awk '{print $5}'`
s=`ls -lL sequence.fastq | awk '{print $5}'`
printf "inputSequence\t%d\n" $((10000*$s/$r)) >> $statFile

printf "aligned_Genome\t%d\n" `wc -l Genomic.algn.bed | awk '{print $1}'` >> $statFile

printf "aligned_rRNA\t%d\n" `wc -l rRNA.algn.tag | awk '{print $1}'` >> $statFile

printf "aligned_repeats\t%d\n" `wc -l multi.inRep.Genomic.algn.bed | awk '{print $1}'` >> $statFile

totalUniqueAlgn=`wc -l unique.Genomic.algn.bed | awk '{print $1}'`

printf "filtered_unique\t%d\n" $totalUniqueAlgn >> $statFile

printf "aligned_splice_junction\t%d\n" `wc -l unique.$juncAlgn | awk '{print $1}'` >> $statFile

cat chromHitCount.tsv >> $statFile

