#$ -cwd

if [ $# -ne 2 ]; then
    echo SYNOPSIS: `basename $0` refDir algnBed
    exit
fi

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

refDir=$1
algn=$2

exonBed=$refDir/exonUTR.refFlat.bed
geneBed=$refDir/isoform.refFlat.bed
fiveUTRbed=$refDir/5utr.refFlat.bed
threeUTRbed=$refDir/3utr.refFlat.bed


filtered=`getTempRandName.sh`.`basename $algn`
if [ -f "$filtered" ]; then
    rm $filtered
fi
ln -s $algn $filtered

# use only alignment with < maxMis mismatch
# sometime buggy: less than 6 fields in a row, so ignore those too
# awk -v M=$maxMis 'NF==6 && $5<=M' $algn  > $filtered

outName=`basename $algn`

total=`wc -l $filtered | awk '{print $1}'`

intergenic=`intersectBed -a $filtered -b $geneBed -v | wc -l`

intersectBed -a $filtered -b $geneBed -f 1.0 -u | cut -f4 > inGene.tag
genic=`wc -l inGene.tag | awk '{print $1}'`

fiveUTR=`intersectBed -a $filtered -b $fiveUTRbed -f 1.0 -u | wc -l`
fiveOut=`intersectBed -a $filtered -b $fiveUTRbed -u | cut -f4 | diff.awk inGene.tag - | wc -l`

threeUTR=`intersectBed -a $filtered -b $threeUTRbed -f 1.0 -u | wc -l`
threOut=`intersectBed -a $filtered -b $threeUTRbed -u | cut -f4 | diff.awk inGene.tag - | wc -l`

#exonic=`intersectBed -a $filtered -b $exonBed -f 1.0 -u | wc -l`
intersectBed -a $filtered -b $exonBed -f 1.0 -u > exonic.$outName
exonic=`wc -l exonic.$outName | awk '{print $1}'`

intersectBed -a $filtered -b $exonBed -u | cut -f4 > coveringExon.tag

intronic=`intersectBed -a $filtered -b $geneBed -u | cut -f4 | diff.awk coveringExon.tag - | wc -l`

cut -f4 exonic.$outName > inExon.tag

exonOut=`diff.awk inExon.tag coveringExon.tag | wc -l`

# todo: not very proper to put this junction counting here
juncAlgn=unique.junction.Refseq.algn
# # see /PIPELINE/bin/countJunctionCoverage.sh
# # count coverage of reads: not in the exonic set, uniquely aligned to a junction
cut -f4 exonic.$outName | diff.awk - $juncAlgn >  exonFiltered.$juncAlgn
junc=`wc -l exonFiltered.$juncAlgn | awk '{print $1}'`

> $outName.coverageSum 

echo -e uniqAlgn '\t' exonic/UTR '\t' 5UTR "\t" 3UTR '\t' exon_intron '\t' intronic '\t' genic '\t' 5UTR_out '\t' 3UTR_out '\t' intergenic '\t' junction >> $outName.coverageSum
echo -e $total '\t' $exonic '\t' $fiveUTR "\t" $threeUTR '\t' $exonOut '\t' $intronic '\t' $genic '\t' $fiveOut '\t' $threOut '\t' $intergenic '\t' $junc >> $outName.coverageSum

cat $outName.coverageSum

rm $filtered inGene.tag coveringExon.tag
