#!/bin/bash

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G,express
#######$ -l h_rt=12:00:00

source error_handling
script_start

list=$1
wd=$2

outDir=$wd/Stage2/`basename $list`.Output

mkdir -p $outDir

pushd $outDir

for i in `cat $list`; do
    mkdir -p $i
    makeLogDir.sh $i
    qsub -l express -b y -V -cwd -e $i/Log -o $i/Log stage2.localVOA.sh $i $wd
done

popd
script_end
