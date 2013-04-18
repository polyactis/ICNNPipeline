#$ -cwd

bam=`dirname $1`/`basename $1 .bam`.bam
sam=`dirname $1`/`basename $1 .sam`.sam

if [ -f $bam ]; then
    samtools view $bam | sam2bed.awk > `dirname $bam`/`basename $bam .bam`.bed
else
    if [ -f $sam ]; then
        sam2bed.awk $sam > `dirname $sam`/`basename $sam .sam`.bed
    else
        echo $1 is not a good sam/bam file
        exit
    fi
fi
