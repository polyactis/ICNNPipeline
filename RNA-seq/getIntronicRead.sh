#$ -cwd
if [ "x`echo $2 | grep -o intron`" == "x" ]; then
    echo need INTRON file in 2nd param
	exit 1
fi

$HOME/bin/intersectBed -a $1 -b $2 -u > intronic.`basename $1`-`basename $2`
