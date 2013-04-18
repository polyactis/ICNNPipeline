#!/bin/bash - 
#===============================================================================
#
#          FILE:  creatMacaqueReferenceFiles.sh
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/26/2010 09:43:22 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

for file in refFlat.txt repMask.tsv genome.fasta; do
    if ! [ -f $file ]; then
        echo $file is missing
        exit 1
    fi
done

refFlat=refFlat.txt
echo using file $refFlat ...

refFlat2ExonBedWithGeneNameOnly.awk $refFlat | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t0\t" $6}' | sort -k1,1 -k2,2n -k3,3n | uniq > $refFlat.exonUTR

ln -s $refFlat.exonUTR exonUTR.refFlat.bed

tempBed=`getTempRandName.sh`.bed
cut -f1-3 exonUTR.refFlat.bed | sort | uniq > $tempBed

fastaFromBed -fi genome.fasta -bed $tempBed -fo $refFlat.exonUTR.fasta
rm $tempBed

fasta2tabdelim.awk $refFlat.exonUTR.fasta | getSpliceJunctionSequence.awk - $refFlat.exonUTR > $refFlat.spliceJunction.fasta

ln -s $refFlat.spliceJunction.fasta spliceJunction.fasta

getUTRbed.awk $refFlat
ln -s $refFlat.3utr 3utr.refFlat.bed
ln -s $refFlat.5utr 5utr.refFlat.bed

refFlat2GeneExonMap.awk $refFlat > $refFlat.geneExonMap
ln -s $refFlat.geneExonMap geneExonMap.refFlat.bed 

awk '{ print $3 "\t" $5 "\t" $6 "\t" $1 "\t" $2 "\t" $4}' $refFlat > $refFlat.isoform
ln -s $refFlat.isoform isoform.refFlat.bed

awk 'NR > 1{print $6 "\t" $7 "\t" $8}' repMask.tsv > $refFlat.repMask
ln -s $refFlat.repMask repMask.bed

createMetaGeneExonBed.sh isoform.refFlat.bed exonUTR.refFlat.bed

samtools faidx genome.fasta
samtools faidx rRNA.fasta
