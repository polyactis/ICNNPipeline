#!/bin/bash - 
#===============================================================================
#
#          FILE:  run.gzip.sh
# 
#         USAGE:  ./run.gzip.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 08/10/2012 03:56:11 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

orig=$1

outDir=`dirname $orig`

[ $# -ge 2 ] && outDir=$2

mkdir -p $outDir

tmpFile=`mktemp --tmpdir=$outDir --suffix=.gz`

gzip -c $orig > $tmpFile

if [ "`zcat $tmpFile | md5sum - | awk '{print $1}'`" == "`md5sum $orig | awk '{print $1}'`" ]; then 
    mv $tmpFile $outDir/`basename $orig`.gz
else
    echo gzip corrupted, stopping ... && rm -f $tmpFile && exit 1
fi

script_end




