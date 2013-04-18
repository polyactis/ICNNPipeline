#!/bin/bash - 
#===============================================================================
#
#          FILE:  startBCLconversion.sh
# 
#         USAGE:  ./startBCLconversion.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (), namtran@ucla.edu
#  ORGANIZATION: ICNN, UCLA
#       CREATED: 10/24/2012 02:42:48 PM PDT
#      REVISION:  ---
#===============================================================================

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G

set -e
source error_handling
script_start

export PATH=/u/home/eeskin2/namtran/Experiment/Demultiplex/Modified_Joe_Pipeline/:$PATH

[ $# -le 2 ] && echo ERROR: need 3 input params ... 1>&2 && exit 1

command=$1

[ $command != "bash" ] && [ $command != "qsub" ] && echo ERROR: first param is bash or qsub 1>&2 && exit 1

projFC=$2
shift

for line in `cat $projFC | sed 's/:* \+smb:.*HiSeq Scans\//_delimiter_/'`; do 
    proj=`echo $line | sed 's/_delimiter_.*//'`; 
    fc=`echo $line | sed 's/.*_delimiter_//'`; 
    mkdir -p Processed/$fc/$proj; 
    grep "`basename $fc`.*$proj" "$@" | awk -F"\t" '{ gsub(/[^a-zA-Z0-9_\-]/,"_",$3); print $3, $5, $6}' > Processed/$fc/$proj/samples.txt; 

    baseCallDir=`pwd`/HiSeqScanServer/$fc/Data/Intensities/BaseCalls

    pushd Processed/$fc/$proj; 

    logDir=`makeLogDir.sh Log/bcl2qseq2fastq`

    for i in `awk '{print $NF}' samples.txt | sed 's/,/\n/g' | sort | uniq`; do 

        if [ $command == "qsub" ]; then
            $command -e $logDir -o $logDir `which bcl2qseq2fastq.sh` $baseCallDir $i 
        else
            bcl2qseq2fastq.sh $baseCallDir $i >$logDir/bcl2qseq2fastq.sh.L$i.out 2>$logDir/bcl2qseq2fastq.sh.L$i.err &
        fi
    done
    popd; 
done

script_end

