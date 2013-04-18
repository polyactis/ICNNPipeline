#!/bin/bash -
#$ -cwd
#

set -o nounset
if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

number=0-9MXY

refseqAlgnDir=Refseq/algn
juncAlgn=junction.Refseq.algn

# if the $juncAlgn file exists, won't be overwritten
# delete it to recompute
if [ -d Refseq/algn ] && ! [ -f $juncAlgn ]; then
    echo extracting junction alignments ...
    > $juncAlgn
    files=`find $refseqAlgnDir -regex .*.part[$number]*.sam`
    for i in $files; do
        ls $i
        #extractAllJunctionAlgn.awk $i | diff.awk BAD.tag - >> $juncAlgn
        extractAllJunctionAlgn.awk $i >> $juncAlgn
    done
fi
awk '$14 ~ /^X0:i:1$/ && $15 ~/^X1:i:0$/' $juncAlgn > unique.$juncAlgn

cut -f4 exonic.unique.Genomic.algn.bed | diff.awk - unique.$juncAlgn | awk '{print $3 "\t" 1}' | aggregate.awk | cut -f1,2 > junction.coverage

geneExonJunctionMap.sh $refDir
