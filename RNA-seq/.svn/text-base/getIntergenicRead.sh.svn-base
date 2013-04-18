#$ -cwd
if [ "x`echo $2 | grep -o gene`" == "x" ]; then
    echo need GENE file in 2nd param
	exit 1
fi
$HOME/bin/intersectBed -a $1 -b $2 -v > intergenic.`basename $1`-`basename $2`

