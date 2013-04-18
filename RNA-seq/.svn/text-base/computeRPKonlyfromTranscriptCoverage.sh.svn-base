#$ -cwd

if [ $# -ne 1 ]; then
	echo SYNOPSIS `basename $0` transcriptCoverageFile
	exit 1
fi

awk '{ print $1 "\t" ($2 == 0? "NA": (1e+3 * $2/$3)) }' $1 | sort -k 1 > RPKonly.`basename $1`
