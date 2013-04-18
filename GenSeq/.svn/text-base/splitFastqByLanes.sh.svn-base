#$ -cwd
#$ -V
#$ -l h_rt=8:00:00

if [ $# -ne 3 ]; then
    echo SYNOPSIS `basename $0` fastq flowcell lane 
fi

set -eux

fastq=$1
flowcell=$2
lane=$3

pushd `dirname $fastq`

fastq=`basename $fastq`

splitFastqByLanes.awk -v flowcell=$flowcell -v lane=$lane $fastq

for i in $fastq.flowcell*lane*; do
    fn=`basename $i | sed 's/\(.*\).\(flowcell.*lane.*\)/\2.\1/'`
    mv $i `dirname $i`/$fn
done

popd
