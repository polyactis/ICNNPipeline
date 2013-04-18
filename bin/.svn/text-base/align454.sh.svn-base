#$ -cwd
#$ -l h_data=4G

. ~/PIPELINE/bin/setGlobalEnv.sh

if [ $# -ne 2 ]; then 
    echo $0 ref fastq
    exit 1
fi

echo command: $0 "$@" 1>&2
echo cwd: `pwd` 1>&2

ref=$1
name=`dirname $2`/`basename $2 .fastq`
fq=$name.fastq

if ! [ -f "$fq" ]; then
    echo fastq $fq does not exist
    exit
fi

out=`echo $ref | sed -e 's/^\.*//' -e 's/\//__/g'`
out=`basename $fq .fastq`-$out.sam

~/local/bin/bwa dbwtsw $ref $fq > $out 

echo sam to bam ... 

sam2bam.sh $ref.fai $out 

echo extracting unique alignments ... 
unique454Alignment.sh $ref.fai $out
