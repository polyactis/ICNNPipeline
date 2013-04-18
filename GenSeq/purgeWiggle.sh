#$ -cwd

if [ $# -ne 2 ]; then
	echo SYPNOSIS: `basename $0` wig readLen
	exit 1
fi

wig=$1
readLen=$2
~/PIPELINE/GenSeq/purgeWiggle.awk -v readLen=$readLen $wig > $wig.purged
