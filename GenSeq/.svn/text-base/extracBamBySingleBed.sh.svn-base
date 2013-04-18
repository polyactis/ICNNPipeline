#$ -cwd
#$ -V
#$ -l h_data=4G

set -eux

bam=$1
bed=$2
out=$3

intersectBed -abam $bam -b $bed > $out
samtools index $out

