#$ -cwd
output=$1.bam
shift
time -p ~/local/samtools/samtools merge $output "$@"
