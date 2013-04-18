#$ -cwd

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 2 ]; then
    echo SYNOPSIS: `basename $0` aln readLen
    exit 1
fi
if ! [ -f "$1" ]; then
    echo file $1 not found
    exit 1
fi

inDir=`dirname $1`
inName=`basename $1`

readLen=$2

aln2Wig.sh $1 $readLen

echo making wiggle for each strand ...

tempFile=`getTempRandName.sh`.`basename $1`
echo $tempFile
ln -s $1 $tempFile

> $tempFile.F
> $tempFile.R

bname=`basename $1 .aln`
rm -f $bname.{F,R}.aln
ln -s $tempFile.F $bname.F.aln
ln -s $tempFile.R $bname.R.aln

awk '{print $0 >> FILENAME "." $3}' $tempFile
for i in F R; do
    aln2Wig.sh $bname.$i.aln $readLen
    rm -f $bname.$i.aln
done

rm -f $tempFile*

