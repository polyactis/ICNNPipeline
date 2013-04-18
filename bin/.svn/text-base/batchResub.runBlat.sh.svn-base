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

rootLogDir=$1
tryAbsolutePath.sh $rootLogDir

ls $@ | wc -l | xargs echo "number of qsub jobs to be resubmitted: "

L=$rootLogDir/Log
D=`ls -l $L | cut -d' ' -f9- | sed 's/Log -> //'`
countUncompletedJobs.sh $D/runBlat.sh.e*

makeLogDir.sh $rootLogDir

for elog in `cat $D/countUncompletedJobs.runBlat.txt`; do
    ref=`head $elog | grep ref= | cut -f2- -d=`
    fasta=`head $elog | grep fasta= | cut -f2- -d=`
    outDir=`head $elog | grep outDir= | cut -f2- -d=`

    qsub -e $rootLogDir/Log -o $rootLogDir/Log ~/PIPELINE/bin/runBlat.sh $ref $fasta $outDir
done

script_end




