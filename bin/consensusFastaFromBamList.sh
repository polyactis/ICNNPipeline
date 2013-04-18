#$ -cwd 

set -e

if [ $# -ne 3 ]; then
    echo $0 referenceFasta bamList region
    exit 1
fi

ref=$1
bamList=$2
region=$3

tempFile=`getTempRandName.sh`.pileup2fq

tempSam=`getTempRandName.sh`.sam

>$tempSam
for bam in `cat $bamList`; do
#echo extracting from $bam 1>&2
    samtools view $bam $region >> $tempSam
done 

sam2bam.sh $ref.fai $tempSam

samtools pileup -cf $ref `basename $tempSam .sam`.bam | samtools.pl pileup2fq - > $tempFile

plusLine=$((`grep -m 1 -n "^+" $tempFile | cut -f1 -d':'` - 1))

bytes=`echo $region | cut -f2 -d':'`
head -$plusLine $tempFile | sed 's/^@/>/' | fasta2tsv.awk | cut -f2 | cut -b$bytes | tr a-z A-Z

rm $tempFile $tempSam `basename $tempSam .sam`.bam*
