#$ -cwd

if [ $# -ne 2 ]; then
	echo SYNOPSIS: `basename $0` algnFile readLen
	exit 1
fi

~/PIPELINE/GenSeq/algn2bed.awk -v readLen=$2 $1 > `echo $1 | sed 's/\.algn$/.bed/'`
