#$ -cwd
#$ -l h_data=4G
#$ -V
#$ -l h_rt=8:00:00

if [ $# -ne 4 ]; then
    echo SYNOPSIS `basename $0` fai bam flowcell lane 
    exit 1
fi

set -eux

fai=$1
bam=$2
flowcell=$3
lane=$4

pushd `dirname $bam`

bam=`basename $bam`

temp=`basename $bam .bam`.sam

samtools view $bam | splitSamByLanes.awk -v flowcell=$flowcell -v lane=$lane -v filename=$temp -

for i in $temp.flowcell*lane*; do
    fn=`basename $i | sed 's/\(.*\).\(flowcell.*lane.*\)/\2.\1/'`
    mv $i $fn
    sam2bam.sh $fai $fn
done

popd
