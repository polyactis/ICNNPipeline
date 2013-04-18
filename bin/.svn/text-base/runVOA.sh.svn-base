#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe shared 12
#$ -l time=24:00:00,highp
#$ -V

source error_handling
script_start

export OMP_NUM_THREADS=11

export PATH=$PATH:/u/home/eeskin/charlesb/bin/

wordLen=$1

#velveth velvet_out_$wordLen $wordLen -short -fastq.gz *.fastq.gz 

velveth velvet_out_$wordLen $wordLen -short -fastq *.fastq 

velvetg velvet_out_$wordLen -min_contig_lgth 100 -read_trkg yes

oases velvet_out_$wordLen

script_end





