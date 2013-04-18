#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

fileDir=$1
fileName=$2

zcat $fileDir/$fileName/s_*_1_*.qseq.gz > QSEQ/${fileName}.qseq
qsub `which gzipit.sh` QSEQ/${fileName}.qseq

