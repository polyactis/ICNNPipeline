#!/bin/bash

#$ -V
#$ -b y
#$ -cwd

source error_handling
script_start

[ $# != 3 ] && echo SYNOPSIS: $0 ref fasta outDir && exit 1 >&2

ref=$1
fasta=$2
outDir=$3

mkdir -p $outDir

psl=$outDir/`basename $fasta`.blat.psl

blat $ref $fasta $psl

best=`dirname $psl`/`basename $psl .psl`.best.psl

awk '/^[0-9]/ && ($1-$2)/$11>0.75 { if (id[$10]==0) id[$10]=1; if (m[$10]-($1-$2)<=0) { a[$10]=$0; m[$10]=$1-$2 } }END{for(i in a) print a[i]}' $psl > $best

gzip -f $psl
gzip -f $best

script_end
