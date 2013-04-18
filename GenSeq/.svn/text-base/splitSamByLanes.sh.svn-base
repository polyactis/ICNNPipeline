#$ -cwd
#$ -V
#$ -l h_rt=8:00:00

if [ $# -ne 3 ]; then
    echo SYNOPSIS `basename $0` sam flowcell lane 
fi

set -eux

splitSamByLanes.awk -v flowcell=$2 -v lane=$3 $1

for i in $1.flowcell*lane*; do
    fn=`basename $i | sed 's/\(.*\).\(flowcell.*lane.*\)/\2.\1/'`
    mv $i `dirname $i`/$fn
done
