#$ -cwd

set -e

if [ $# -ne 2 ]; then
    echo $0 fai sam
    exit 1
fi
fai=$1
sam=$2
tempID=`getTempRandName.sh`.ID
tempSam=`getTempRandName.sh`.sam

#samtools view $bam | awk '{print $1 "\t" 1}' | aggregate.awk | awk '$2 == 1 { print $1 }' > $tempID 
#samtools view $bam | insect.awk $tempID - | sed 's/ \+/\t/g'> $tempSam

~/PIPELINE/bin/good454Alignment.awk $sam > $tempSam

bam=`dirname $sam`/`basename $sam .sam`.uniqueAlgn.bam

sam2bam.sh $fai $tempSam
mv `basename $tempSam .sam`.bam $bam

mv `basename $tempSam .sam`.bam.bai $bam.bai

rm -f $tempID $tempSam


