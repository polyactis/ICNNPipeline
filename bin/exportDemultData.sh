#!/bin/bash - 
#===============================================================================
#
#          FILE:  exportDemultData.sh
# 
#         USAGE:  ./exportDemultData.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 10/18/2012 03:11:12 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

d=`echo $1 | sed 's/^.*Processed\///'`

#mkdir -p /u/scratch/n/namtran/HiSeqData
mkdir -p /u/home/eeskin2/namtran/Public/HiSeqData

chmod og+rx /u/home/eeskin2/namtran/Public/HiSeqData /u/home/eeskin2/namtran/Public

pushd /u/home/eeskin/namtran/Public/HiSeqData

mkdir -p $d
pushd $d
rm -rf FASTQs QSEQs
mkdir FASTQs QSEQs

ln -f ~/panasas/Experiment/Demultiplex/Processed/$d/FASTQs/* FASTQs
for i in `find ~/panasas/Experiment/Demultiplex/Processed/$d -maxdepth 1 -type d -name L00*`; do mkdir -p QSEQs/`basename $i`; ln -f $i/*_qseq.txt* QSEQs/`basename $i`; done

echo new data at `pwd`
popd

popd

pushd /u/home/eeskin2/namtran/Public/HiSeqData

chmod -R go+r .
find . -type d | xargs chmod go+x

popd

script_end
