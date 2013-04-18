#$ -cwd
#$ -l h_data=4G

set -eux

ref=$1
name=`dirname $2`/`basename $2 _1.fastq`

first=${name}_1.fastq
second=${name}_2.fastq

if ! [ -f "$first" ] || ! [ -f "$second" ]; then
    echo $first or $second does not exist
    exit 1
fi

out=`dirname $name`/`basename $ref`-`basename $name`.sam

bwa aln $ref $first > $first.sai
bwa aln $ref $second > $second.sai

bwa sampe $ref $first.sai $second.sai $first $second | tee >(awk '$3 != "*"' > $out) | awk '$3=="*"' | fastqFromSam.awk > `dirname $name`/`basename $ref`-`basename $name`.unmapped.fastq
