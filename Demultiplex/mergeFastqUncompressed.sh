#!/bin/bash - 

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G,time=23:0:0

set -e
source error_handling
script_start


fileDir=$1
fileName=$2

fastqList=`ls $fileDir/$fileName/s_*_1_*.fastq | sed 's/\(\/s_[1-8]\)_1_\([^\/]\+\)/\1_fooAsDummyString_\2/' | sort | join - <(ls $fileDir/$fileName/s_*_2_*.fastq | sed 's/\(\/s_[1-8]\)_2_\([^\/]\+\)/\1_fooAsDummyString_\2/' | sort)`

cat `echo $fastqList | sed 's/fooAsDummyString/1/g'` > FASTQs/${fileName}_1.fastq
#qsub `which gzipit.sh` FASTQs/${fileName}_1.fastq

cat `echo $fastqList | sed 's/fooAsDummyString/2/g'` > FASTQs/${fileName}_2.fastq
#qsub `which gzipit.sh` FASTQs/${fileName}_2.fastq

script_end
