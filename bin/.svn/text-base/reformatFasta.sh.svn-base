#!/bin/bash

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G
#######$ -l h_rt=12:00:00

source error_handling
script_start

fasta=$1
len=$2

reformatFasta.awk -v len=$len $fasta > `basename $fasta`.reformated_L$len

script_end
