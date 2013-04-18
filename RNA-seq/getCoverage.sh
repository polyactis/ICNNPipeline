#$ -V
#$ -b y
#$ -cwd
if [ $# -ne 2 ]; then
	echo SYNOPSIS: $0 reads.6colBed exon.6colBed \(0-based start, UCSC GB\)
fi
# read coverage of exons
$HOME/bin/coverageBed -a $1 -b $2 > coverage.`basename $1`-`basename $2`
