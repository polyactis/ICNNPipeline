#!/bin/bash 
#$ -V
#$ -cwd
#$ -b y
#$ -l h_data=4G

set -eux

fq=$1

~/PIPELINE/bin/shiftBackIlluminaQualScore.awk $fq > `dirname $fq`/from64to33.`basename $fq`

echo shiftBackIlluminaQualScore.awk done
