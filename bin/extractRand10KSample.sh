#$ -V
#$ -cwd

set -eux

fastq=$1

script=randomFastq.sh

out=`dirname $fastq`/sample10000.`basename $fastq`

other=`echo $fastq | sed 's/_1\.fastq$/_2.fastq/'`

echo $other
if [ $other != $fastq ] && [ -f $other ]; then
    script=randomPairedFastq.sh
    out=`echo $out | sed 's/_1\.fastq$/.fastq/'`
fi

$script $fastq 10000

fastq2number.awk $out
