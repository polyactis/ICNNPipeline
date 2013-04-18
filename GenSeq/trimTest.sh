#!/bin/bash - 
#===============================================================================
#
#          FILE:  trimTest.sh
# 
#         USAGE:  ./trimTest.sh algnIndex fastq
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
#       COMPANY: ICNN, UCLA
#       CREATED: 02/26/2010 12:23:14 AM PST
#      REVISION:  ---
#===============================================================================

#$ -cwd
#$ -l h_data=1024M
#$ -pe shared 8

set -o nounset                              # Treat unset variables as an error

binDir=~/PIPELINE/bin
index=$1
fastq=$2
name=`basename $fastq`
outDir=`echo $name | sed 's/\.fastq$//'`.output

rm -rf $outDir
mkdir -p $outDir

len=`head -2 $fastq | tail -1 | awk '{print length($1)}'`
echo read length is $len

for i in `seq 25 $len`; do
    echo trimming reads to first $i bases ...
    trim=$outDir/prefix$i
    $binDir/cutReadPrefix.awk -v len=$i $fastq > $trim.fastq
    echo aligning to $index ...
    /u/local/apps/bwa/0.5.0/bwa aln $index $trim.fastq > $trim.sai
    /u/local/apps/bwa/0.5.0/bwa samse $index $trim.sai $trim.fastq > $trim.sam
    echo computing QC stats ...
    $binDir/qcStat.awk $trim.sam
done
