# # #!/bin/bash - 
# # #===============================================================================
# # #
# # #          FILE:  gsPipe.sh
# # # 
# # #         USAGE:  ./gsPipe.sh 
# # # 
# # #   DESCRIPTION:  RNA-seq pipeline, Gena and Shaohong data, to become good template
# # # 
# # #       OPTIONS:  ---
# # #  REQUIREMENTS:  ---
# # #          BUGS:  ---
# # #         NOTES:  ---
# # #        AUTHOR: Nam Tran (NT), ntran@mednet.ucla.edu
# # #       COMPANY: ICNN, UCLA
# # #       CREATED: 03/11/2010 06:46:28 PM PST
# # #      REVISION:  ---
# # #===============================================================================

#$ -V
#$ -cwd 
#$ -l h_rt=12:00:00
 
set -o nounset                              # Treat unset variables as an error
if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH:/u/local/bin
fi

if ! [ -f sampleList.txt ]; then
    echo sampleList.txt file does not exist, will be automatically created
    find -L . -name Genomic.algn.bam -printf "%h\n" | sed 's/^\.\///' > sampleList.txt
fi

sampleList=`cat sampleList.txt`

echo gene refseq chr strand recordNum $sampleList | sed 's/ \+/\t/g' > isofRPKM.xls
isofList=`cat sampleList.txt | awk '{print $0 "/isof.rpkm.tsv"}'`
cjoin.awk $isofList | sed 's/:/\t/g' >> isofRPKM.xls

echo gene $sampleList| sed 's/ /\t/g' > metaRPKM.xls
metaList=`cat sampleList.txt | awk '{print $0 "/meta.rpkm.tsv"}'`
cjoin.awk $metaList >> metaRPKM.xls

echo variable $sampleList | sed 's/ \+/\t/g' > allStatistics.xls
cjoin.awk `echo $sampleList | sed 's/ \+/\n/g' | awk '{print $1 "/allStatistics.tsv"}'` | awk 'NR > 1' >> allStatistics.xls

~/PIPELINE/RNA-seq/Patch/getBatchReadCount.sh

echo start plotting ...
R CMD BATCH ~/PIPELINE/RNA-seq/allPlot.R

R CMD BATCH ~/PIPELINE/RNA-seq/duplicationAnalysisPlot.R
