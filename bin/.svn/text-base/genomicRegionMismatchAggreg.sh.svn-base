#$ -cwd

set -e

echo command: $0 "$@" 1>&2
echo cwd: `pwd` 1>&2

. ~/PIPELINE/bin/setGlobalEnv.sh

if [ $# -ne 2 ]; then
    echo SYNOPSIS `basename $0` bam regionBed
    exit
fi

bam=$1
bed=$2

outDir=`dirname $bam`/`basename $bam .bam`
mkdir -p $outDir

samtools view $bam | sam2bed.awk | intersectBed -a stdin -b $bed -wb -f 1.0 | awk '{print $11 "\t" $7}' | aggregate.awk | awk '{print $1 "\t" $2/$3 "\t" $2 "\t" $3}' > $outDir/`basename $bed .bed`-conservStat.xls

echo completed successfully! 1>&2
