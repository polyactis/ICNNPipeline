#!/bin/bash

#$ -V
#$ -b y
#$ -cwd

source error_handling
script_start

ref=$1
file=$2

T=2:0:0
[ $# -eq 3 ] && T=$3

d=$file.blat/`dirname $ref | xargs basename`

mkdir -p $d/Input $d/Output
fasta2tsv.awk $file | shuffle.awk | awk '{print ">" $1 "\n" $2}' | split -a 3 -d -l 2000 - $d/Input/`basename $file`.part

makeLogDir.sh $d
ls $d/Input/`basename $file`.part* | xargs -I{} qsub -l time=$T -e $d/Log -o $d/Log ~/PIPELINE/bin/runBlat.sh $ref {} $d/Output

script_end

