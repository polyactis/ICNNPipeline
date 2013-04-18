#$ -cwd

if [ "x$1" != "x-" ]; then
    awk 'NR%4==1 { id = substr($1,2) } NR%4==2 { seq = $1 } NR%4==0 {print id "\t" seq "\t" $1}' $1 > `dirname $1`/`basename $1 .fastq`.tsv
else
    awk 'NR%4==1 { id = substr($1,2) } NR%4==2 { seq = $1 } NR%4==0 {print id "\t" seq "\t" $1}' $1
fi

