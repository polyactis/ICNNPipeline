#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

awk 'BEGIN {print "LANE\tTOTAL_BasePairs\tTOTAL>Phred20\tTOTAL>Phred30\tTOTAL_PASSED\tPASS>Phred20\tPASS>Phred30"}' > STATS/laneSTATS

for i in `find -maxdepth 1 -name "L*"`; do echo `basename $i` | sed 's/L00//' ; done > lanes.txt

for lane in `cat lanes.txt`; do
	grep ^$lane STATS/allSTATS | awk -v lane=$lane '{sum1+=$3}{sum2+=$4}{sum3+=$5}{sum4+=$6}{sum5+=$7}{sum6+=$8} END {print "L00"lane "\t" sum1 "\t" sum2 "\t" sum3 "\t" sum4 "\t" sum5 "\t" sum6}' >> STATS/laneSTATS;
done

rm lanes.txt; 
