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

if [ $# -eq 1 ]; then
    pubDir=`mktemp -d --tmpdir=$SCRATCH`
else
    pubDir=$2
fi

pushd $pubDir

mkdir -p $d
pushd $d

rm -rf FASTQs QSEQs
mkdir FASTQs QSEQs

rsync -rvL --size-only --progress ~/panasas/Experiment/Demultiplex/Processed/$d/FASTQs/* FASTQs
for i in `find ~/panasas/Experiment/Demultiplex/Processed/$d -maxdepth 1 -type d -name L00*`; do mkdir -p QSEQs/`basename $i`; rsync -rvL --size-only --progress $i/*_qseq.txt* QSEQs/`basename $i`; done

echo $d `pwd` | tee -a publicExportLocation.txt

popd

chmod -R go+r .

popd

script_end
