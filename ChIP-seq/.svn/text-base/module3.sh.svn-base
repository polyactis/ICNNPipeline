#$ -cwd
#$ -l h_data=1024M
#$ -pe shared 4

# Name Dec 12 2011
echo mergeSortedBed.awk has changed 
exit 1

set -o nounset                              # Treat unset variables as an error

#if [ $# -ne 1 ]; then
#    echo SYNOPSIS: `basename $0` refDir
#    exit
#fi

#refDir=$1

if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH
fi

sampleFastq=sample10000.sequence.fastq
maxReadLen=`awk 'NR%4==2{ if (len < length($1)) len = length($1)}END{print len}' $sampleFastq`
aveReadLen=`awk 'NR%4==2{ len+= length($1); count++}END{print len/count}' $sampleFastq`

# filtered wiggles for high regions
baseline=5
rmDupName=rmDup.unique.Genomic

aln2Wig.sh rmDup.unique.Genomic.F.aln $maxReadLen
aln2Wig.sh rmDup.unique.Genomic.R.aln $maxReadLen
aln2Wig.sh rmDup.unique.Genomic.aln $maxReadLen

for i in $rmDupName.*.wig; do
    wigFilteredByHeight.awk -v baseline=$baseline $i > $i.baseline_$baseline
done

for i in F R; do
    file=rmDup.unique.Genomic.$i
    awk -v rdLen=$maxReadLen '{print $1 "\t" ($2>0?$2-1:0) "\t" $2-1+rdLen "\t" 1}' $file.aln | mergeSortedBed.awk > $file.bed
done

cat rmDup.unique.Genomic.F.bed rmDup.unique.Genomic.R.bed | sort -k1,1 -k2,2n -k3,3n | mergeSortedBed.awk > rmDup.unique.Genomic.bed




