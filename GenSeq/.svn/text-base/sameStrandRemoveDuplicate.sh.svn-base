#$ -cwd

if [ $# -ne 2 ]; then
	echo SYNOPSIS `basename $0` bam'|'sam gapSize
	exit 1
fi

. ~/PIPELINE/bin/setGlobalEnv.sh

if [ "x`echo $1 | grep -o "\.bam$"`" == "x.bam" ]; then
	samtools view $1 | ~/PIPELINE/GenSeq/sameStrandRemoveDuplicate.awk -v gap=$2 > $1.rmdup
else
	~/PIPELINE/GenSeq/sameStrandRemoveDuplicate.awk -v gap=$2 $1 > $1.rmdup
fi
