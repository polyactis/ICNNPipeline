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
#$ -V
#$ -cwd
#$ -l h_data=4096M
#$ -l h_rt=24:00:00

set -eux

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1

number=0-9MXY
genomicRef=$refDir/genome.fasta
genomicAlgnDir=Genomic/algn

# making a BAM of all alignments
>rRNA.algn.tag
if [ -d rRNA/algn ] && ! [ -f rRNA.algn.bam ] ; then
    echo extracting rRNA alignments ...
    mergeBamsUnderDir.sh rRNA/algn  ### bam file is to be created after every alignment
fi
if [ -f rRNA.algn.bam ]; then
    echo "not doing now" 
    #    samtools view rRNA.algn.bam | awk '$3 !~ /^\*$/ {print $1}' >> rRNA.algn.tag
fi

if [ -d Genomic/algn ] && ! [ -f Genomic.algn.bam ]; then 
    echo extracting Genomic alignments ...
    mergeBamsUnderDir.sh Genomic/algn  ### bam file is to be created after every alignment
fi
# sam2bed also filter and select only algn with mismatch <= 0.05 read length
    samtools view Genomic.algn.bam | sam2bed.awk > Genomic.algn.bed

# more correct to count only unique alignment, as for multiple alignment the assignment is arbitrary
    awk '$5==1{ count[$1]++ }END{ for (i in count) print i "\t" count[i] }' Genomic.algn.bed | sortChromData.sh - > chromHitCount.tsv

    cut -f5 Genomic.algn.bed > multi.Genomic.algn.bed
    intersectBed -a Genomic.algn.bed -b $refDir/repMask.bed -f 1.0 -u | cut -f4-5 > inRep.Genomic.algn.bed
    cut -f2 inRep.Genomic.algn.bed > multi.inRep.Genomic.algn.bed
#    cut -f1 inRep.Genomic.algn.bed > BAD.tag 
    > BAD.tag

    cat rRNA.algn.tag >> BAD.tag
     
    awk '$1=="chrM"{print $4}' Genomic.algn.bed >> BAD.tag

    awk '{print $4 "\t" $0}' Genomic.algn.bed | diff.awk BAD.tag - | cut -f2- >  filtered.Genomic.algn.bed

# this is for plotting alignment statistics: hit counts, mismatch distribution
    totalRead=`samtools view Genomic.algn.bam | wc -l`
    echo -e $totalRead '\t' 0 > algnStat.txt
    cut -f5,7 filtered.Genomic.algn.bed >> algnStat.txt


    echo extracting unique alignment
    awk '$5==1' filtered.Genomic.algn.bed > unique.Genomic.algn.bed


# junction alignment
refseqAlgnDir=Refseq/algn
juncAlgn=junction.Refseq.algn
#if [ -d Refseq/algn ] && ! [ -f $juncAlgn ]; then

> $juncAlgn
if ! [ -f $juncAlgn ] && [ -f Refseq.algn.bam]; then
    echo extracting junction alignments ...
###    files=`find $refseqAlgnDir -regex .*.part[$number]*.sam`
###    for i in $files; do
###        ls $i
###        extractAllJunctionAlgn.awk $i | diff.awk BAD.tag - >> $juncAlgn
###    done
    samtools view Refseq.algn.bam | extractAllJunctionAlgn.awk | diff.awk BAD.tag - > $juncAlgn
fi

awk '$14 ~ /^X0:i:1$/ && $15 ~/^X1:i:0$/' $juncAlgn > unique.$juncAlgn

echo counting coverage: reads hitting exon, intron, genes, etc ...
RNA-seq.countAllCoverage.sh $refDir unique.Genomic.algn.bed #flag2fix: move away above the junction stat

echo computing RPKM

echo ... junction coverage
countJunctionCoverage.awk exonFiltered.unique.$juncAlgn > junction.coverage #flag2fix: not need this script, replace it with one line, see Splicing/computeSpliceJunctionStat.sh

nsample=10000
fastq2number.sh sample$nsample.sequence.fastq

sam2bed.awk junction.Refseq.algn | cut -f5,7 - > multi.junction.Refseq.algn

# some more stats: rRNA repeats etc 
    echo totalRead $totalRead > moreAlgnStat.txt
    echo rRNA `wc -l rRNA.algn.tag | awk '{print $1}'` >> moreAlgnStat.txt
    echo inRep `wc -l multi.inRep.Genomic.algn.bed | awk '{print $1}'` >> moreAlgnStat.txt


# put statistics in tsv file
statFile=allStatistics.tsv
printf "variable\t%s\n" `basename $PWD` > $statFile

printf "inputSequence\t%d\n" `awk 'NR==1{print $1}' algnStat.txt` >> $statFile

printf "aligned_Genome\t%d\n" `wc -l Genomic.algn.bed | awk '{print $1}'` >> $statFile

printf "aligned_rRNA\t%d\n" `wc -l rRNA.algn.tag | awk '{print $1}'` >> $statFile

printf "aligned_repeats\t%d\n" `wc -l multi.inRep.Genomic.algn.bed | awk '{print $1}'` >> $statFile

totalUniqueAlgn=`wc -l unique.Genomic.algn.bed | awk '{print $1}'`
printf "filtered_unique\t%d\n" $totalUniqueAlgn >> $statFile

printf "aligned_splice_junction\t%d\n" `wc -l unique.$juncAlgn | awk '{print $1}'` >> $statFile

cat chromHitCount.tsv >> $statFile

echo starting patches ...

~/PIPELINE/RNA-seq/fixMetaRPKMWithFewerRows.sh $refDir
~/PIPELINE/RNA-seq/Patch/addRefseqAlgnCount.sh

echo duplicate statistics ...
uniqueAlgnBed=unique.Genomic.algn.bed
awk '{print $1 ":" $2 "\t" 1}' $uniqueAlgnBed | aggregate.awk | awk '{print $2 "\t" 1}' | aggregate.awk | sort -k1,1n > duplicateCount.tsv


