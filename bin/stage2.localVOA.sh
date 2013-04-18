#!/bin/bash

#$ -V
#$ -b y
#$ -cwd
#$ -l h_data=4G,express

source error_handling
script_start

gene=$1
velvetDir=$2

mkdir -p $gene

pushd $gene

find -L $velvetDir/Alignment2Pairs/ -name *.bam | xargs -I{} samtools view {} | awk '$3~/:'$gene'$/' | fastqFromSam.awk | gzip -c > $gene.fastq.gz

export OMP_NUM_THREADS=11
export PATH=$PATH:/u/home/eeskin/charlesb/bin/

for i in `seq 19 4 71`; do
#    runVOA.sh $i
    wordLen=$i

    velveth velvet_out_$wordLen $wordLen -short -fastq.gz $gene.fastq.gz 

    velvetg velvet_out_$wordLen -min_contig_lgth 100 -read_trkg yes

    oases velvet_out_$wordLen
    
    for f in Sequences LastGraph Graph2 PreGraph Roadmaps; do
        rm -f velvet_out_$wordLen/$f
    done
    
done

popd

script_end

