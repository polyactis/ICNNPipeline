#$ -cwd
if [ $# -ne 2 ]; then
	echo SYNOPSIS: `basename $0` fastq len
    exit
fi
~/pipeline/ChIP-seq/cutReadPrefix.awk -v len=$2 $1 > `basename $1 .fastq`.prefix$2.fastq
