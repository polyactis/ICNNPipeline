#$ -cwd
#$ -V

set -eux

bam=$1
beDir=$2

bamPartDir=$bam.`basename $beDir`

mkdir -p $bamPartDir

for i in `find -L $beDir -type f -name "*part[0-9][0-9].bed"`; do
    echo $i
    part=`basename $i | sed 's/.*\(part[0-9][0-9]\).bed/\1/'`
    qsub `which extracBamBySingleBed.sh` $bam $i $bamPartDir/$part.bam
done 

