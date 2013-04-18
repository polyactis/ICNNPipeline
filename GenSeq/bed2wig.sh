#$ -cwd
#$ -l h_data=4096M

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` BED
    exit
fi

set -eux

file=`dirname $1`/`basename $1 .bed`

awk '{ print $1 "\t" $2+1; len = (len+0 < $3-$2)?$3-$2:len }END{ print len > ( FILENAME ".readLen")}' $1 > $file.aln

readLen=`cat $1.readLen`
echo read length is $readLen

aln2Wig.sh $file.aln $readLen

pileupStat.awk $file.readLen${readLen}.wig > $file.readLen${readLen}.wig.pileStat

