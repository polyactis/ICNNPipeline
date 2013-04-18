#!/bin/bash - 
#===============================================================================
#
#          FILE:  fixMetaRPKMWithFewerRows.sh
# 
#         USAGE:  ./fixMetaRPKMWithFewerRows.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 04/13/2010 05:12:19 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd
set -o nounset                              # Treat unset variables as an error

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

refDir=$1
geneExonJunctionMap.sh $refDir

echo ... genomic coverage
geneExonMap=$refDir/geneExonMap.refFlat.bed
coverageBed -a unique.Genomic.algn.bed -b $geneExonMap > exon.coverage 


echo combining genomic and junction read counts ...
cut -f4,7 exon.coverage | aggregate.awk | awk '$2 > 0' > isof.exon.coverage

awk '{print $2 "\t" $1}' geneJunctionMap.tsv | insect.awk junction.coverage - | awk '{print $3 "\t" $2}' | aggregate.awk | awk '$2>0' > isof.junction.coverage

cut -f4,5 $geneExonMap | addGenomicRefseqReadCount.awk - isof.exon.coverage isof.junction.coverage > combinedReadCount.tsv

echo computing meta-gene RPKM ...
metaExonBed=$refDir/meta.exonUTR.refFlat.bed

totalRefseqReadCount=`awk 'NR==2{print $2+$NF}' unique.Genomic.algn.bed.coverageSum`

coverageBed -a unique.Genomic.algn.bed -b $metaExonBed | cut -f4,7 | aggregate.awk > meta.exon.coverage 
sed 's/:/\t/g' isof.junction.coverage | cut -f1,6 | aggregate.awk > meta.junction.coverage

awk '{print $4 "\t" $3-$2}' $metaExonBed | aggregate.awk | addGenomicRefseqReadCount.awk - meta.exon.coverage meta.junction.coverage > meta.combinedReadCount.tsv

awk -v total=$totalRefseqReadCount '{ print $1 "\t" ($2==0?0:1e+9*$2/$3/total)}' combinedReadCount.tsv > isof.rpkm.tsv
awk -v total=$totalRefseqReadCount '{ print $1 "\t" ($2==0?0:1e+9*$2/$3/total)}' meta.combinedReadCount.tsv> meta.rpkm.tsv
