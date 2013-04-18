#$ -cwd

. ~/PIPELINE/bin/setGlobalEnv.sh

if [ $# -ne 1 ]; then
    echo $0 fastq
    exit 1
fi

fq=$1
tempFile=`getTempRandName.sh`.$fq


awk 'NR%4==2 { gsub(/\./,"N",$1) }{ print }' $fq > $tempFile
mv $tempFile $fq
