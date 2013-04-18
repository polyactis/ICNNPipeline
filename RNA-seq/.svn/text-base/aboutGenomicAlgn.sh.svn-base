#!/bin/bash - 
#===============================================================================
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
set -o nounset                              # Treat unset variables as an error

bin=~/PIPELINE/bin
number=0-9MXY
genomicAlgnDir=Genomic/algn
genomicBed=uniqueGenomicAlgn.bed


echo extracting genomic unique alignments to BED
> $genomicBed
files=`find $genomicAlgnDir -regex .*.part[$number]*.sam`
for i in $files; do
    ls $i
    $bin/extractUniqueAlgn2Bed.awk $i >> $genomicBed
done

#misM=2
#$bin/countAllCoverage.sh $genomicBed $misM
$bin/countAllCoverage.sh $genomicBed 1
$bin/countAllCoverage.sh $genomicBed 2

#refseqAlgnDir=Refseq/algn
#refseqBed=refseqAlgn.bed
#echo extracting junction unique alignments to BED
#> $refseqBed
#files=`find $refseqAlgnDir -regex .*.part[$number]*.sam`
#for i in $files; do
#    ls $i
#    $bin/extractJunctionAlgn2Bed.awk $i >> $refseqBed
#done
