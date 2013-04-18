mkdir Temp
pushd Temp
for i in `find .. -name Genomic.algn.bam -printf "%h\n"`; do ln -s $i/sample10000.sequence.fastq `basename $i`; done
find . -type l -printf "%f\n" > sampleList
QC.qualBoxPlot.Rcmd sampleList
mv sampleList_base_qual.png ../baseQuality.png
popd
