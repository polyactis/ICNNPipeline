#!/bin/bash - 
#===============================================================================
#
#          FILE:  rerun.runBlat.sh
# 
#         USAGE:  ./rerun.runBlat.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 12/12/2011 02:03:40 PM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

elog=$1
newLog=$2

mkdir -p $newLog

ref=`head $elog | grep ref= | cut -f2- -d=`
fasta=`head $elog | grep fasta= | cut -f2- -d=`
outDir=`head $elog | grep outDir= | cut -f2- -d=`

qsub -e $newLog -o $newLog -l h_data=4G,time=4:0:0 ~/PIPELINE/bin/runBlat.sh $ref $fasta $outDir

script_end




