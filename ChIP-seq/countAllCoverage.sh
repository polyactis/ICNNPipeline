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

geneBed=$refDir/isoform.refFlat.bed

filtered=temporary.`basename $algn`
if [ -f "$filtered" ]; then
    rm $filtered
fi
ln -s $algn $filtered

outName=`basename $algn`

total=`wc -l $filtered | awk '{print $1}'`

intergenic=`intersectBed -a $filtered -b $geneBed -v | wc -l`

intersectBed -a $filtered -b $geneBed -f 1.0 -u | cut -f4 > inGene.tag
genic=`wc -l inGene.tag | awk '{print $1}'`

echo -e uniqAlgn '\t' genic '\t' intergenic >>  $outName.coverageSum
echo -e $total '\t'  $genic '\t' $intergenic >> $outName.coverageSum

cat $outName.coverageSum

rm $filtered inGene.tag
