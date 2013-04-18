#$ -cwd
if [ "x`echo $2 | grep -o exon`" == "x" ]; then
	echo need EXON file in 2nd param
	exit 1
fi
$HOME/bin/intersectBed -a $1 -b $2 -u > exonic.`basename $1`-`basename $2`
