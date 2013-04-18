#!/bin/bash 

#$ -V
#$ -cwd
#$ -l h_data=4G,h_rt=4:00:00

set -ux

name=`dirname $1`/`basename $1 _1.fastq`
threshold=$2

first=${name}_1.fastq
second=${name}_2.fastq

if ! [ -f "$first" ] || ! [ -f "$second" ]; then
    echo $first or $second does not exist
    exit 1
fi

script=softTrimSingleEndReads.awk

firstTrim=`dirname $first`/softTrim$threshold.`basename $first`
secondTrim=`dirname $second`/softTrim$threshold.`basename $second`

>$firstTrim
>$secondTrim

join <($script -v q=$threshold $first | fastq2tsv.awk | sed 's/^\(@[^ ]*\)\/1/\1/') \
<($script -v q=$threshold $second | fastq2tsv.awk | sed 's/^\(@[^ ]*\)\/2/\1/') |\
awk '{print $1 "/1\n" $2 "\n+\n" $3 >> "'$firstTrim'"; print $1 "/2\n" $4 "\n+\n" $5 >> "'$secondTrim'"}'

