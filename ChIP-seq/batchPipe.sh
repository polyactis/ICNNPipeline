# # #!/bin/bash - 
 
#$ -cwd 
 
set -o nounset                              # Treat unset variables as an error
if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1
if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH:/u/local/bin
fi

if ! [ -f sampleList.txt ]; then
    echo sampleList.txt file does not exist, will be automatically created
    find -L . -name Genomic.algn.bam -printf "%h\n" | sed 's/^\.\///' > sampleList.txt
fi

for i in `cat sampleList.txt`; do
    pushd $i > /dev/null
    echo fixing in $i ...
    ~/PIPELINE/ChIP-seq/Patch/fixSampleStatistics.sh $refDir
    R CMD BATCH ~/PIPELINE/ChIP-seq/addMoreSampleStatistics.R
    cat chromHit.X-squared >> sampleStatistics.tsv
    popd > /dev/null
done

cjoin.awk `awk '{print $1 "/sampleStatistics.tsv"}' sampleList.txt` > batchStatistics.xls

echo start plotting ...
R CMD BATCH ~/PIPELINE/ChIP-seq/allPlot.R
R CMD BATCH ~/PIPELINE/ChIP-seq/bindingPlot.R

