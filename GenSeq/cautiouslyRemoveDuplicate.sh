#$ -cwd

tool=~/local/samtools/samtools
rmdup=~/PIPELINE/bin/sameStrandRemoveDuplicate.awk

if [ $# -ne 2 ]; then
	echo SYNOPSIS: `basename $0` bam gap
	exit 1
fi

bam=$1
gap=$2
samOut=`echo $bam | sed 's/\.bam$//'`.rmdup.sam

$tool view $bam | awk '{ if (and($2,16) == 0) print }' | $rmdup -v gap=$gap > $samOut
$tool view $bam | awk '{ if (and($2,16) == 16) print }' | $rmdup -v gap=$gap >> $samOut
