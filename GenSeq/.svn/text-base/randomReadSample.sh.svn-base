#$ -cwd

total=`wc -l $1 | awk '{print $1}'`
total=$((total/4))
echo total=$total
nsample=200000
~/pipeline/ChIP-seq/randomReadSample.awk -v total=$total -v nsample=$nsample $1 > sample.`basename $1`
