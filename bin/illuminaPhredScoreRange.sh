set -eu

fastq=$1


catCmd=cat
[ `basename $fastq | grep -c .fastq.gz$` -eq 1 ] && catCmd=zcat

$catCmd $fastq | head -1000 | awk 'NR%4==0' | sed 's/./&\n/g' | sort | grep -m 1 -n Z | wc -l | xargs echo $fastq
