#$ -cwd
#$ -l h_data=4G

. ~/PIPELINE/bin/setGlobalEnv.sh

if [ $# -ne 2 ]; then
    echo SYNOPSIS `basename $0` fai bam
    exit
fi


fai=$1
bam=$2

if ! [ -f $bam.bai ]; then
    echo index of $bam does not exist
    exit
fi

for i in `awk '{print $1}' $fai`; do
    out=`basename $bam .bam`.$i.bam
    samtools view $bam $i | samtools import $fai - $out
    temp=`getTempRandName.sh`.`basename $out .bam`
    samtools sort $out $temp
    mv $temp.bam $out
    samtools index $out
done
