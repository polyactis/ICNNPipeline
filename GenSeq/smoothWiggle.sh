#$ -cwd
if [ $# -ne 2 ]; then
	echo SYNOPSIS: `basename $0` wiggleFile windowSize
	exit 1
fi
~/PIPELINE/GenSeq/smoothWiggle.awk -v window=$2 $1 > $1.smooth_$2
