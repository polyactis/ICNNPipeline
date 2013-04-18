set -eux

ref=$1
fq=$2

file=`dirname $fq`/`basename $fq _1.fastq`

temp=`getTempRandName.sh`.`basename $file`.tempDir
rm -rf $temp
mkdir $temp

for i in 1 2; do
    bwa aln $ref ${file}_$i.fastq | bwa samse $ref - ${file}_$i.fastq | awk 'NF > 10 && $3 != "*"{print "@" $1 "/'$i'"}' | sort > $temp/single.mappable.$i
done

join -t'/' -o1.1,1.2 $temp/single.mappable.1 $temp/single.mappable.2 | tee $temp/paired.mappable.1 | sed 's/\/[12]$/\/2/' > $temp/paired.mappable.2

for i in 1 2; do
    fastq2tsv.awk ${file}_$i.fastq | sort -k1,1 | join $temp/paired.mappable.$i - | awk '{print $1 "\n" $2 "\n+\n" $3}' > $temp/paired.mappable.sequence_$i.fastq
done

first=$temp/paired.mappable.sequence_1.fastq
second=$temp/paired.mappable.sequence_2.fastq

out=`basename $ref`
out=`dirname $ref | xargs basename`_$out
out=`dirname $file`/`basename $file`-$out.sam

echo final output is $out

bwa aln $ref $first > $first.sai
bwa aln $ref $second > $second.sai

bwa sampe $ref $first.sai $second.sai $first $second | awk '$3 != "*"' > $out

#bwa sampe $ref <(bwa aln $ref $first) <(bwa aln $ref $second) $first $second | awk '$3 != "*"' > $out
####tee >(awk '$3 != "*"' > $out) | awk '$3=="*"' | fastqFromSam.awk > `dirname $file`/`basename $ref`-`basename $file`.unmapped.fastq



