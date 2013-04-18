#$ -cwd
#$ -l h_data=4G

if [ $# -ne 3 ]; then
    echo $0 ref fastq maxHit
    exit 1
fi

ref=$1
name=`dirname $2`/`basename $2 .fastq`
fq=$name.fastq
maxHit=$3

if ! [ -f "$fq" ]; then
    echo fastq $fq does not exist
    exit
fi

readLen=`head -2 $fq | tail -1 | awk '{print length($1)}'`

echo read length is $readLen

out=`echo $ref | sed -e 's/^[\/\.]\+//' -e 's/\//__/g'`
out=`basename $fq`-$out.sam

bwa=~/TOOLS/BWA/bwa
if [ $maxHit -gt 0 ]; then
    $bwa aln $ref $fq | $bwa samse -n $maxHit $ref - $fq | awk '$3 != "*"' > $out 
else
    $bwa aln $ref $fq | $bwa samse $ref - $fq | awk '$3 != "*"' > $out 
fi
