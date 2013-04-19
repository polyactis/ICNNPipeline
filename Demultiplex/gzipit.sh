#!/bin/bash - 

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G,time=23:0:0


set -e
source error_handling
script_start

gzip -f $@


script_end




