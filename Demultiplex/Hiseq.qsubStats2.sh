#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

#if [ $# -ne 1 ]; then
#    echo sample list needed, formated with three columns:
#    echo Sample_ID     Illumina_Index   Lanes "(separated by commas, i.e. 1,3,7)"
#    exit 1
#fi

awk 'BEGIN {print "LANE\tTILE\tTOTAL_BasePairs\tTOTAL>Phred20\tTOTAL>Phred30\tTOTAL_Passed\tPASS>Phred20\tPASS>Phred30"}'> STATS/allSTATS
awk 'BEGIN {print "LANE\tTILE\tTAG\tTOTAL_BasePairs\tTOTAL>Phred20\tTOTAL>Phred30\tTOTAL_Passed\tPASS>Phred20\tPASS>Phred30"}' > STATS/indexSTATS

cat STATS/all/* >> STATS/allSTATS
cat STATS/index/* >> STATS/indexSTATS

`which laneStats.sh`;
`which tileStats.sh`;

sampleList=$1
illumina_index=/u/home/eeskin/jwhitake/PIPELINE/Hiseq.v1.0/illumina_indexes.txt
len=`wc -l $sampleList | awk '{print $1}'`

awk 'BEGIN {print "SAMPLE\tTOTAL_BasePairs\tTOTAL>Phred20\tTOTAL>Phred30\tTOTAL_PASS\tPASS>Phred20\tPASS>Phred30"}' > STATS/sampleSTATS

for i in `seq 1 $len`; do
        sample=`awk -v i=$i 'NR==i {print $1}' $sampleList`;
        tagtemp=`awk -v i=$i 'NR==i {print $2}' $sampleList`;
        tag=`grep -w $tagtemp $illumina_index | awk '{print $2}'`;
        awk -v i=$i 'NR==i {split($3,a,","); for (j=1;j<=length(a);j++) print "^"a[j]}' $sampleList > ${sample}_${tag}_lanes.txt
	egrep $tag STATS/indexSTATS | egrep -f ${sample}_${tag}_lanes.txt | awk -v sample=$sample '{sum1 += $4}{sum2 +=$5}{sum3+=$6}{sum4+=$7}{sum5+=$8}{sum6+=$9} END {print sample "\t" (sum1+0) "\t" (sum2+0) "\t" (sum3+0) "\t" (sum4+0) "\t" (sum5+0) "\t" (sum6+0)}' >> STATS/sampleSTATS
        rm ${sample}_${tag}_lanes.txt;
done

