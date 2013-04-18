#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

find -name "s_*_2_*_qseq.txt.gz" | awk '{split($1,a,"_"); print a[4]}' | sort | uniq > tiles.txt

awk 'BEGIN {print "TILE\tTOTAL_BasePairs\tTOTAL>Phred20\tTOTAL>Phred30\tTOTAL_PASSED\tPASS>Phred20\tPASS>Phred30"}' > STATS/tileSTATS

for tile in `cat tiles.txt`; do
	cut -f2- STATS/allSTATS | grep ^$tile | awk -v tile=$tile '{sum1+=$2}{sum2+=$3}{sum3+=$4}{sum4+=$5}{sum5+=$6}{sum6+=$7} END {print tile "\t" sum1 "\t" sum2 "\t" sum3 "\t" sum4 "\t" sum5 "\t" sum6}' >> STATS/tileSTATS;
done

rm tiles.txt 
