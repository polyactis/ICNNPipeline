#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

lane=$1;
tile=$2;

forward=s_${lane}_1_${tile}_qseq.txt.gz;
index=s_${lane}_2_${tile}_qseq.txt.gz;
reverse=s_${lane}_3_${tile}_qseq.txt.gz;

stats=`zcat $forward $reverse | cut -f10,11 | /u/home/eeskin/jwhitake/PIPELINE/Hiseq.v1.0/baseQuality.awk`

total=`echo $stats | awk '{print $1}'`
phred20=`echo $stats | awk '{print $2}'`
phred30=`echo $stats | awk '{print $3}'`
pass=`echo $stats | awk '{print $4}'`
passphred20=`echo $stats | awk '{print $5}'`
passphred30=`echo $stats | awk '{print $6}'`

awk -v lane=$lane -v tile=$tile -v total=$total -v phred20=$phred20 -v phred30=$phred30 -v pass=$pass -v passphred20=$passphred20 -v passphred30=$passphred30 'BEGIN {print lane "\t" tile "\t"  (total+0) "\t" (phred20+0) "\t" (phred30+0) "\t" (pass+0) "\t" (passphred20+0) "\t" (passphred30+0)}' >> ../STATS/all/$lane.$tile.txt;


