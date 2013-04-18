if [ $# -ne 1 ]; then
	echo SYNOPSIS `basename $0` transcriptCoverageFile
	exit 1
fi

totalRead=`awk '{ s+=$2}END{print s}' $1`

awk -v total=$totalRead '{ print $1 "\t" ($2 == 0? "NA": (1e+9 * $2/$3/total)) }' $1 | sort -k 1 
