#$ -cwd
bin=~/PIPELINE/RNA-seq/
$bin/exon2GenePairRefseqCoverage.awk $1 | $bin/exon2TranscriptCoverage.awk | sort -k 1 > transcript.`basename $1`
