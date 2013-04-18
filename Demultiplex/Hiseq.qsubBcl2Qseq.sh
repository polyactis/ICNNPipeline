#/bin/bash - 

#$ -V
#$ -cwd 

set -e
source error_handling
script_start


if [ $# -ne 1 ]; then
    echo BaseCalls directory needed!
    exit 1
fi

bcDir=$1

for i in `awk '{print $3}' samples.txt | sed 's/,/\n/g' | sort | uniq`; do 
	qsub `which bcl2qseq2fastq.sh` "$bcDir" $i;
done

script_end
