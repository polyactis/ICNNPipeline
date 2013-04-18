#$ -cwd
#$ -l h_data=1024M
#$ -pe shared 8 

if [ $# -ne 3 ]; then
	echo SYNOPSIS: `basename $0` ref.fai bam gap
	exit 1
fi

tool=~/local/samtools/samtools

ref=$1
bam=$2
gap=$3
samOut=`echo $bam | sed 's/\.bam$//'`.rmdup_gap$gap.sam
rmdup=~/PIPELINE/bin/sameStrandRemoveDuplicate.awk

#~/PIPELINE/bin/removeDuplicate.sh $bam $gap
$tool view $bam | awk '{ if (!and($2,16) && !and($2,4) ) print }' | $rmdup -v gap=$gap > $samOut
$tool view $bam | awk '{ if (and($2,16) && !and($2,4) ) print }' | $rmdup -v gap=$gap >> $samOut
~/PIPELINE/bin/sam2bam.sh $ref $samOut
