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

sort -k1,1 Transcriptomic.algn.bed | join - $refDir/refGene.tsv.isoformCount | sed 's/^[^ ]*_refGene_N/N/' | awk '$5 <= $9 { print $8 ":" $1 "\t" 1 }' | aggregate.awk | cut -f1-2 | sort -k1,1 > isoform.junction.unique.Transcriptomic.algn.count

# see ~/PIPELINE/RNA-seq/fixMetaRPKMWithFewerRows.sh
# starting with combinedReadCount.tsv and meta.combinedReadCount.tsv
# assuming no count of alignment to junctions (Refseq dir)

version=version01242011
cat combinedReadCount.tsv | sed 's/^\([^:]*:[^:]*\):/\1\t/' | sort -k1,1 | join -a1 - isoform.junction.unique.Transcriptomic.algn.count | awk '{print $1 ":" $2 "\t" $3+(NF==5?$5:0) "\t" $4}' > combinedReadCount.tsv.$version

sort -k1,1 meta.combinedReadCount.tsv > sorted.meta.combinedReadCount.tsv

sed 's/:/\t/' isoform.junction.unique.Transcriptomic.algn.count | cut -f1,3 | aggregate.awk | sort -k2,2rn | cut -f1-2 | sort -k1,1 | join -a1 sorted.meta.combinedReadCount.tsv - | awk '{print $1 "\t" $2+(NF==4?$4:0) "\t" $3}' > meta.combinedReadCount.tsv.$version


totalRefseqReadCount=$((`awk 'NR==2{print $2}' unique.Genomic.algn.bed.coverageSum` + `awk 'END{print NR}' isoform.junction.unique.Transcriptomic.algn.count`))


awk -v total=$totalRefseqReadCount '{ print $1 "\t" ($2==0?0:1e+9*$2/$3/total)}' combinedReadCount.tsv.$version > isof.rpkm.tsv.$version
awk -v total=$totalRefseqReadCount '{ print $1 "\t" ($2==0?0:1e+9*$2/$3/total)}' meta.combinedReadCount.tsv.$version > meta.rpkm.tsv.$version


