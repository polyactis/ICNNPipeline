#!/bin/bash - 
set -o nounset                              # Treat unset variables as an error

if [ $# -ne 1 ]; then
    echo SYNOPSIS: `basename $0` refDir
    exit
fi

refDir=$1
tempFile=`getTempRandName.sh`.batchDirList

for i in `find -L . -name Genomic.algn.bam.bai`; do
    d=`dirname $i`
    d=`dirname $d`
    echo $d
done | sort | uniq > $tempFile

tempGeneFile=`getTempRandName.sh`.geneNeighbor5K.bed

awk '{print $3 "\t" ($5>5000?$5-5000:0) "\t" $6+5000 "\t" $1 "\t" $2 "\t" $4}' $refDir/refFlat.txt > $tempGeneFile

for sample in `cat $tempFile`; do
    echo $sample
    pushd $sample > /dev/null
    cp ~/PIPELINE/ChIP-seq/report.tex . 
    for f in *.png; do
        convert $f `basename $f .png`.eps
    done
    latex report.tex
    dvipdfm -p letter report.dvi
    if ! [ -d Results ]; then
        mkdir Results
    fi
    cp report.pdf batchStatistics.xls Results 

    echo copy peak lists ...
    find cisgenome/ -name peak2nd.cod -exec cod2bed.sh '{}' \;
    cisPeakDir=Peaks/cisgenome
    mkdir -p $cisPeakDir
    for b in `find cisgenome/ -name peak2nd.bed`; do
        xls=$cisPeakDir/`echo $b | sed -e 's/cisgenome\///' -e 's/result\/peak2nd.bed/xls/' -e 's/\//./g'`
        intersectBed -a $b -b $tempGeneFile -wa -wb | awk '{print $42 "\t" $43 "\t" $44 "\t" $0}' | cut -f1-41 > $xls
        cp $xls Results
        rm -f $cisPeakDir/*.inverted*
    done
    echo -e '#peaks\tcell_line\twindow_size\tFDR\tsample_combination' > Results/peakCount.xls
    wc -l $cisPeakDir/*Window*FDR*.xls | grep -v total | sed -e 's/ Peaks\/cisgenome\//\t/' -e 's/\(.*\)\.Window\([0-9]*\)-FDR\([0-9\.]*\)\./\1\t\2\t\3\t/' -e 's/1-sample\.//' -e 's/\.xls//' | sort -k2,2 -k3,3n -k4,4n -k5,5 >> Results/peakCount.xls
    popd > /dev/null
done

rm $tempFile $tempGeneFile
