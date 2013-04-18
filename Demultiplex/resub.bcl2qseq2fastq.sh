#!/bin/bash - 
#===============================================================================
#
#          FILE:  rerun.bcl2qseq2fastq.sh
# 
#         USAGE:  ./rerun.bcl2qseq2fastq.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 11/26/2012 09:00:57 AM PST
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

logDir=`makeLogDir.sh Log/resub.bcl2qseq2fastq`
pipeDir=/u/home/eeskin2/namtran/Experiment/Demultiplex/Modified_Joe_Pipeline/

for logFile in $@; do

    cwd=`head $logFile | grep -m1 cwd: | cut -d' ' -f2-`
    bclDir=`head $logFile | grep -m 1 bcDir= | cut -d= -f2-`
    lane=`head $logFile | grep -m 1 lane= | cut -d= -f2-`
    export PATH=$pipeDir:$PATH

    pushd $cwd

    qsub -e $logDir -o $logDir $pipeDir/bcl2qseq2fastq.sh $bclDir $lane

    popd

done

script_end


