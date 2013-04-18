#!/bin/bash - 
#===============================================================================
#
#          FILE:  convertQualScoreIllumina2Sanger.sh
# 
#         USAGE:  ./convertQualScoreIllumina2Sanger.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 03/08/2013 01:18:06 PM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G,time=4:0:0

set -e
source error_handling
script_start

fq=$1

catCmd=cat
[ `basename $fq | grep -c "\.fastq\.gz$"` -eq 1 ] && catCmd=zcat

outDir=$2
mkdir -p $outDir

pushd `dirname $fq` > /dev/null
dir1=`pwd`
popd > /dev/null

pushd $outDir > /dev/null
dir2=`pwd`
popd > /dev/null

[ $dir1 == $dir2 ] && echo ERROR: the same input and output directory && exit 1

$catCmd $fq | ~/PIPELINE/bin/shiftBackIlluminaQualScore.awk | gzip > $outDir/`basename $fq`

script_end




