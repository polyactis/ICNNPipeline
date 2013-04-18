#$ -cwd

set -e

if [ $# -ne 1 ]; then
    echo $0 dir_of_qseq
    exit 1
fi

echo cwd: `pwd` 1>&2
echo command: $0 "$@" 1>&2

d=$1
fq=$d.fastq
> $fq

for i in $d/*_qseq.txt; do
    awk '{ id = $1; for (i=2; i<=8; i++) id = id ":" $i; print "@" id ":" $11 "\n" $9 "\n+\n" $10}' $i >> $fq
done
