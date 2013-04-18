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
set -o nounset                              # Treat unset variables as an error

#export PATH=$PATH:~/PIPELINE/bin:~/local/samtools
if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

number=0-9MXY
genomicRef=~/Data/RefGenome/Human/hg18.fasta
junctionRef=~/Data/RefGenome/Human/HG18/SpliceJunctionIndex/bwtst
genomicAlgnDir=Genomic/algn

# making a BAM of all alignments
>rRNA.algn.tag
if [ -f rRNA ]; then
    echo extracting rRNA alignments
    manySam2Bam.sh ~/Data/RefGenome/Human/HG18/Variation/rRNA.fasta.fai rRNA/algn
    samtools view rRNA.algn.bam | awk '$3 !~ /^\*$/' >> rRNA.algn.tag
fi

    echo extracting Genomic alignments
    manySam2Bam.sh $genomicRef.fai Genomic/algn
# sam2bed also filter and select only algn with mismatch <= 0.05 read length
    echo ... checking repeats
    samtools view Genomic.algn.bam | sam2bed.awk | intersectBed -a stdin -b ~/Data/RefGenome/Human/HG18/Variation/repmask327.bed -f 1.0 -u > inRep.Genomic.algn.bed
    cut -f4 inRep.Genomic.algn.bed > inRep.tag
    cat rRNA.algn.tag inRep.tag > BAD.tag
    samtools view Genomic.algn.bam | diff.awk BAD.tag - | sam2bed.awk >  all.Genomic.algn.bed

# this is for plotting alignment statistics: hit counts, mismatch distribution
    totalRead=`samtools view Genomic.algn.bam | wc -l`
    echo -e $totalRead '\t' 0 > algnStat.txt
    cut -f5,7 all.Genomic.algn.bed >> algnStat.txt

    echo extracting unique alignment
    samtools view Genomic.algn.bam | diff.awk BAD.tag - | awk '$14 ~ /^X0:i:1$/ && $15 ~/^X1:i:0$/' > unique.Genomic.algn

    sam2bed.awk unique.Genomic.algn > unique.Genomic.algn.bed

    awk '{ count[$3]++ }END{ for (i in count) print i "\t" count[i] }' unique.Genomic.algn > chromHitCount.tsv

# junction alignment
echo junction alignment
refseqAlgnDir=Refseq/algn
juncAlgn=junction.Refseq.algn
> $juncAlgn
files=`find $refseqAlgnDir -regex .*.part[$number]*.sam`
for i in $files; do
    ls $i
#    extractAllJunctionAlgn.awk $i >> $juncAlgn
    extractAllJunctionAlgn.awk $i | diff.awk BAD.tag - >> $juncAlgn

done
awk '$14 ~ /^X0:i:1$/ && $15 ~/^X1:i:0$/' $juncAlgn > unique.$juncAlgn

echo counting coverage: reads hitting exon, intron, genes, etc ...
countAllCoverage.sh unique.Genomic.algn.bed 

echo computing RPKM

echo ... junction coverage
countJunctionCoverage.awk exonFiltered.unique.$juncAlgn > junction.coverage

# linking gene to exons and junctions
geneExonJunctionMap.sh

echo ... genomic coverage
#coverageBed -a unique.Genomic.algn.bed -b exonUTR.refFlat.bed > exon.coverage 
coverageBed -a unique.Genomic.algn.bed -b geneExonMap.refFlat.bed > exon.coverage 


echo combining genomic and junction read counts ...
#combinedRPKM.awk exon.coverage junction.coverage ~/Data/RefGenome/Human/HG18/refFlat.txt > combinedReadCount.tsv
cut -f4,7 exon.coverage | aggregate.awk | awk '$2 > 0' > gene.exon.coverage

awk '{print $2 "\t" $1}' geneJunctionMap.tsv | insect.awk junction.coverage - | awk '{print $3 "\t" $2}' | aggregate.awk | awk '$2>0' > gene.junction.coverage

cut -f4,5 geneExonMap.refFlat.bed | addGenomicRefseqReadCount.awk - gene.exon.coverage gene.junction.coverage > combinedReadCount.tsv

nsample=10000
randomFastq.sh sequence.fastq $nsample
fastq2number.sh sample$nsample.sequence.fastq
padWithNA.sh sample$nsample.sequence.fastq.base
padWithNA.sh sample$nsample.sequence.fastq.qual

# for plotting
cut -f5,7 all.Genomic.algn.bed > multi.all.Genomic.algn.bed
cut -f5 inRep.Genomic.algn.bed > multi.inRep.Genomic.algn.bed
sam2bed.awk junction.Refseq.algn | cut -f5,7 - > multi.junction.Refseq.algn
# R plotting
