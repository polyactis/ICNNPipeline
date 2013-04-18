#!/bin/bash -f
#$ -cwd
#$ -l h_data=1024M
#$ -pe shared 4

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

genomicRef=$1/genome.fasta

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

if [ -d Genomic ] && ! [ -f Genomic.algn.bam.bai ]; then
    echo making bam file
    manySam2Bam.sh $genomicRef.fai Genomic/algn

# in the future: delete all sam files
fi
echo extracting Genomic alignments from bam to bed
samtools view Genomic.algn.bam | sam2bed.awk > Genomic.algn.bed

# for plotting quality
nsample=10000
nRead=`samtools view Genomic.algn.bam | wc -l`
sampleFastq=sample$nsample.sequence.fastq
samtools view Genomic.algn.bam | randomLines.awk -v nsample=$nsample -v total=$nRead | fastqFromSam.awk > $sampleFastq 
fastq2number.sh $sampleFastq

# quick hack. will remove once bed2wig available
readLen=`awk 'NR%4==2 {len = length($1); count = count < len? len: count} END{print count}' sample10000.sequence.fastq`

uniqueAlgnBed=unique.Genomic.algn.bed
uniqName=rmDup.unique.Genomic

#echo filter for unique alignment with MISMATCHES less than 3
#time awk '$5==1 && $7<=2' Genomic.algn.bed > $uniqueAlgnBed
# already filtered for 0.05 mismatch rate in sam2bed.awk
time awk '$5==1' Genomic.algn.bed > $uniqueAlgnBed

echo splitting and writing out read locations on the two strands ...

# making *.aln files from bed
# NOTE: 1-base coordinate in *.aln files
time awk 'BEGIN{ ("basename " ARGV[1] " .algn.bed") | getline outName; outName = "rmDup." outName "." }{print $1 "\t" $2+1 | ("uniq>" outName ($6 == "+"?"F":"R")) ".aln"}' $uniqueAlgnBed

#for i in F R; do
#    time aln2Wig.sh $uniqName.$i.aln $readLen
#done

time awk '{print $0 "\tF"}' $uniqName.F.aln > $uniqName.aln
time awk '{print $0 "\tR"}' $uniqName.R.aln >> $uniqName.aln
#time aln2Wig.sh $uniqName.aln $readLen

#smoothWiggle.sh $uniqName.F.readLen$readLen.wig $readLen
#smoothWiggle.sh $uniqName.R.readLen$readLen.wig $readLen
#smoothWiggle.sh $uniqName.readLen$readLen.wig $readLen


