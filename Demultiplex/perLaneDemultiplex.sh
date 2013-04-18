#!/bin/bash - 

#$ -V
#$ -b y
#$ -cwd 
#$ -l h_rt=24:00:00

set -e
source error_handling
script_start

export PATH=/u/home/eeskin/icnn/local/bin/:$PATH

mileDir=milestone

OLB=/u/home/eeskin/jwhitake/Tools/OLB-1.9.4/bin
lane=$1

pushd L00$lane > /dev/null

rm -f $mileDir/demultiplexed

illuminaFile=`which illumina_indexes.txt`

tagList=`cat ../samples.txt | awk '$NF ~/'$lane'/{print $(NF-1)}' | sort | join - <(sort -k1,1 $illuminaFile) | cut -d' ' -f2 | xargs echo | sed 's/ /,/g'`
splitQseqByIndex.sh ./ $tagList ./

echo INFO demultiplexing completed ... 1>&2

touch $mileDir/demultiplexed

popd > /dev/null

script_end




