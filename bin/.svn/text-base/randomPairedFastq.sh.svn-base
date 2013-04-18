#! /bin/bash
#$ -V
#$ -cwd

set -eu
fastq=$1
#total=`awk 'BEGIN{ RS="@" } END{ print NR-1}' $fastq`
#echo total fastq record: $total
nsample=$2

if [ $# -ne 2 ]; then
    echo $0 fastq nsample
    exit
fi

echo WARNING this may work for Illumina paired-end only! 1>&2

paired=`echo $fastq | sed 's/\(.*\)_1\([^_]\+\)$/\1_2\2/'`
if [ $fastq == $paired ]; then
    echo ERROR bad filenames: $fastq and $paired the same in pair 1>&2
    exit 1
else
    if ! [ -f "$paired" ]; then
        echo the paired file $paired does not exist
        exit 1
    fi
    echo INFO the other in pair is $paired
fi

echo number of random records: $nsample

firstRand=`dirname $fastq`/sample$2.`basename $fastq`

randomFastq.awk -v nsample=$nsample $fastq | fastq2tsv.awk | sort | uniq | sort -k1,1 | awk '{print $1 "\n" $2 "\n+\n" $3}' > $firstRand

awk 'NR%4==1' $firstRand | sed 's/1$/2/' | sort | uniq > $firstRand.ID  

fqLen=$((`wc -l $firstRand | awk '{print $1/4}'`))
numID=`wc -l $firstRand.ID | awk '{print $1}'`

echo fqLen=$fqLen
echo numID=$numID

if [ $fqLen -ne $numID ]; then
    echo duplicate read ID, different sequences
    exit 1
fi

secondRand=`echo $firstRand | sed 's/\(.*\)_1.fastq/\1_2.fastq/'`

fastq2tsv.awk $paired | insect.awk $firstRand.ID - | sort -k1,1 | awk '{print $1 "\n" $2 "\n+\n" $3}' > $secondRand

name=`echo $firstRand | sed 's/_1\([^_]\+\)$/\1/'`
cat $firstRand $secondRand > $name

rm $firstRand.ID


    
