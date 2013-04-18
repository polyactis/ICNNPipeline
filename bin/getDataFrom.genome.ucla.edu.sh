#$ -cwd

set -e
echo cwd: `pwd` 1>&2
echo command: $0 "$@" 1>&2

if [ $# != 3 ]; then
    echo $0 runID laneNum
    exit 1
fi

host=$1
run=$2
lane=$3

rootURL="http://$host/~solexa/solexa_datasets/"
user="gkonopka@ucla.edu"
passwd="dhglab"

fileList=`wget --http-user=$user --http-passwd=$passwd $rootURL/$run/Data/Intensities/BaseCalls/ -O - | grep href | grep -o ">s_${lane}_.*qseq.txt<" | sed -e 's/[><]//g'`

log=wget.run-$run.lane-$lane.log

mkdir -p $run/$lane
pushd $run/$lane
echo getting run $run lane $lane
for i in $fileList; do
    echo file $i ...
    wget -a ../$log --http-user=$user --http-passwd=$passwd $rootURL/$run/Data/Intensities/BaseCalls/$i
done
popd 


