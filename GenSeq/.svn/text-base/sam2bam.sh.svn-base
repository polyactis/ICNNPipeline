#$ -V
#$ -cwd
if [ $# -ne 2 ]; then
	echo SYNOPSIS: `basename $0` faiFile samFile 
	exit 1
fi

source error_handling.sh

start_script

ST=samtools
ref=$1
sam=$2
name=`echo $sam | sed 's/\.sam$//'`
temp=$name.sorted

$ST view -Sb -t $1 $sam > $name.bam
$ST sort $name.bam $temp
mv $temp.bam $name.bam
$ST index $name.bam 

end_script
