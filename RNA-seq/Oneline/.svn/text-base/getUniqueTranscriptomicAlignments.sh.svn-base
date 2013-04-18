#$ -cwd

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

sort -k1,1 Transcriptomic.algn.bed | join - $refDir/refGene.tsv.isoformCount | awk '$5 <= $9 { print $8 "\t" 1 }' | aggregate.awk | cut -f1-2 > isoform.junction.unique.Transcriptomic.algn.count
