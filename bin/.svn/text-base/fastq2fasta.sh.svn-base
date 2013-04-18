#$ -cwd

if [ $# -ne 1 ]; then
    echo SYNOPSIS `basename $0` file.fastq
    echo OUTPUT: file.fasta
    exit
fi

awk 'NR%4==1{ sub(/^@/,">",$1); print $1 }NR%4==2{print}' $1 > `dirname $1`/`basename $1 .fastq`.fasta
