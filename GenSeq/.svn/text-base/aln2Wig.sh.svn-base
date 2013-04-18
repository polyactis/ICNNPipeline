#$ -cwd

set -xeu                              # Treat unset variables as an error

if [ $# -lt 2 ]; then
        echo SYNOPSIS: algn readLen
        exit 1
fi

if ! [ -f $1 ]; then
	echo file $1 doesn\'t exist
	exit 1
fi

origAlgn=$1
readLen=$2

algn=`getTempRandName.sh`.`basename $origAlgn`

ln -s $origAlgn $algn

awk '{ print $2 "\t" $3 >> FILENAME "." $1 }' $algn

chrFiles=`find . -maxdepth 1 -type f -name "$algn.*"`

outName=`dirname $origAlgn`/`basename $origAlgn .aln`
outFile=$outName.readLen${readLen}.wig

echo browser position chr1 > $outFile
echo track type=wiggle_0 name=$outName visibility=full priority=1 maxHeightPixels=50 autoScale=on >> $outFile

echo making wiggle, chrom-by-chrom ... 
for f in $chrFiles; do
	if [ -s $f ] ; then 
        ~/PIPELINE/GenSeq/aln2Wig.pl $f $readLen 1 >> $outFile
	fi
done
rm -f $algn.chr* $algn

