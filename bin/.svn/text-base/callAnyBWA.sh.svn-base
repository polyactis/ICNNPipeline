#$ -cwd
#$ -l h_data=4G

if [ $# -lt 3 ]; then
    echo `basename $0` bwa referenceFasta fastq "[maxHit]"
    exit 1
fi

bwa=$1
ref=$2
name=`basename $3 .fastq`
fq=$name.fastq

if ! [ -f "$fq" ]; then
    echo fastq $fq does not exist
    exit
fi

#readLen=`head -2 $fq | tail -1 | awk '{print length($1)}'`

#echo read length is $readLen

out=`echo $ref | sed -e 's/^\.//' -e 's/\//__/g'`
out=$fq-$out.sam

echo output file is $out

if [ $# -eq 3 ]; then 
    $bwa aln $ref $fq | $bwa samse $ref - $fq | awk '$3 != "*"' > $out 
else
    maxHit=$4
    $bwa aln $ref $fq | $bwa samse -n $maxHit $ref - $fq | awk '$3 != "*"' > $out 
fi
