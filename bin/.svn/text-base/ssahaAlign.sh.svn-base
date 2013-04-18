#$ -cwd
#$ -l h_data=4G
#$ -l h_rt=24:00:00

. ~/PIPELINE/bin/setGlobalEnv.sh

if [ $# -ne 2 ]; then 
    echo $0 ssahaIdx fastq
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

out=`echo $ref | sed -e 's/^\.//' -e 's/\//__/g'`
out=`dirname $fq`/`basename $fq .fastq`-$out.sam

ssaha2 -rtype 454 -output sam_soft -outfile $out $ref $fq 

echo sam to bam ... 

sam2bam.sh $ref.fai $out 

echo extracting unique alignments ... 
unique454Alignment.sh $ref.fai $out
