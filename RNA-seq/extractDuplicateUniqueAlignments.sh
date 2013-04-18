#$ -cwd
#$ -l h_data=2G

set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo `basename $0` minDupCount
    exit
fi

. ~/PIPELINE/bin/setGlobalEnv.sh

awkScript=~/PIPELINE/RNA-seq/extractIDsofDuplicateUniqueAlignments.awk

algnBed=unique.Genomic.algn.bed

minDupCount=$1

$awkScript $algnBed > $algnBed.dupStat

samtools view Genomic.algn.bam | awk 'FILENAME==ARGV[1] && $2-'$minDupCount'>0{ id[$1] = 1}FILENAME==ARGV[2]{ if (id[$1] == 1) print }' $algnBed.dupStat - | fastqFromSam.awk > dup$minDupCount.sequence.fastq 


