#$ -cwd
#$ -V
#$ -l h_data

if [ $# -lt 3 ]; then
    echo `basename $0` bam bed_dir suffix
    exit 1
fi
set -eux

bam=$1
beDir=$2
suffix=$3
prog="qsub -cwd -V -b y"
if [ $# -eq 3 ]; then 
    prog=""
fi

bamPartDir=$bam.$suffix

mkdir -p $bamPartDir

for i in `find -L $beDir -type f -name "*part[0-9][0-9].bed"`; do
    echo $i
    part=`basename $i | sed 's/.*\(part[0-9][0-9]\).bed/\1/'`
    if [ "$prog" != "" ]; then
        $prog `which intersectBed` "-abam $bam -b $i > $bamPartDir/$part.bam"
    else
        intersectBed -abam $bam -b $i > $bamPartDir/$part.bam
    fi
    pushd `dirname $i`
    fullDir=`pwd -P`
    popd
    pushd $bamPartDir 
    ln -sf $fullDir/`basename $i` $part.bed 
    popd
#    samtools index $bamPartDir/$part.bam
done 

