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

ChIP-seq.postProcessAlignment.sh $refDir

# more correct to count only unique alignment, as for multiple alignment the assignment is arbitrary

cut -f5 Genomic.algn.bed > multi.Genomic.algn.bed
intersectBed -a Genomic.algn.bed -b $refDir/repMask.bed -f 1.0 -u | cut -f4-5 > inRep.Genomic.algn.bed

cut -f2 inRep.Genomic.algn.bed > multi.inRep.Genomic.algn.bed

# alignment statistics
totalRead=`samtools view Genomic.algn.bam | wc -l`
echo -e $totalRead '\t' 0 > algnStat.txt
cut -f5,7 unique.Genomic.algn.bed >> algnStat.txt

statFile=sampleStatistics.tsv
printf "count\t%s\n" `basename $PWD` >$statFile

printf "inputSequence\t%d\n" $totalRead >> $statFile

filterDup.sh $refDir
compAllStatistics.sh $refDir

# peak statistics
~/PIPELINE/ChIP-seq/module3.sh


# cleaning
rm tempRandLabel*
