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

logDir=`makeLogDir.sh Log/resub.mergeFastq`
pipeDir=/u/home/eeskin2/namtran/Experiment/Demultiplex/Modified_Joe_Pipeline/

for logFile in $@; do

    cwd=`head $logFile | grep -m1 cwd: | cut -d' ' -f2-`
    fileDir=`head $logFile | grep -m 1 fileDir= | cut -d= -f2-`
    fileName=`head $logFile | grep -m 1 fileName= | cut -d= -f2-`
    export PATH=$pipeDir:$PATH

    pushd $cwd

    qsub -e $logDir -o $logDir $pipeDir/mergeFastq.sh $fileDir $fileName

    popd

done

script_end


