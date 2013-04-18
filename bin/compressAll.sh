#!/bin/bash

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G,highp,time=336:00:00
#######$ -l h_rt=12:00:00

source error_handling
script_start

find . -type f -size +10M -regex ".*\(tsv\|bed\|coverage\|algn\|tag\|coverageSum\|fastq\)" -exec gzip -vf '{}' \;

script_end
