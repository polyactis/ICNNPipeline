#!/bin/bash - 
#===============================================================================
#
#          FILE:  Nullify.sh
# 
#         USAGE:  ./Nullify.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 03/16/2010 05:01:15 AM PDT
#      REVISION:  ---
#===============================================================================

#$ -cwd

set -o nounset                              # Treat unset variables as an error

set -e

echo command: $0 "$@" 1>&2
echo cwd: `pwd` 1>&2

if [ $# -ne 3 ]; then
    echo SYNOPSIS: `basename $0` fastq maxLen qual
    exit 1
fi
 
if ! [ -f `dirname $1`/`basename $1 .fastq`.fastq ]; then
    echo file `dirname $1`/`basename $1 .fastq`.fastq does not exist
    exit 1
fi

outDir=`dirname $1`/VarTrim.maxLen$2.minQual$3
mkdir -p $outDir

~/PIPELINE/bin/trim454Fastq.awk -v L=$2 -v q=$3 $1 > $outDir/`basename $1 .fastq`.fastq 

