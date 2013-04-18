#!/bin/bash - 
#===============================================================================
#
#          FILE:  rerun.qsub.runBlat.sh
# 
#         USAGE:  ./rerun.qsub.runBlat.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 12/12/2011 12:29:16 PM PST
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

cwd=`head $elog | grep cwd: | cut -f2- -d' '`
ref=`head $elog | grep ref= | cut -f2- -d=`
file=`head $elog | grep file= | cut -f2- -d=`

pushd $cwd > /dev/null
qsub -e $newLog -o $newLog /u/home/eeskin/namtran/PIPELINE/bin/qsub.runBlat.sh $ref $file
popd > /dev/null
script_end
