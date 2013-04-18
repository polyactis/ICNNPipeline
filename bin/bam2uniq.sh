#$ -cwd

if [ $# -ne 2 ]; then
    echo $0 fai bam
    exit 1
fi

bam=$1
file=`basename $bam .bam`

. ~/PIPELINE/bin/setGlobalEnv.sh

samtools view $bam | awk '/\WX0:i:1\W/ && /\WX1:i:0\W/' | samtools import $fai - $file.uniqueAlgn.bam

tempFile=$file.`getTempRandName.sh`
samtools sort $file.uniqueAlgn.bam $tempFile
mv $tempFile.bam $file.uniqueAlgn.bam
samtools index $file.uniqueAlgn.bam

