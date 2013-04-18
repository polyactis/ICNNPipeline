#!/bin/bash - 

#$ -V
#$ -cwd 
#$ -l h_rt=24:00:00

set -e
source error_handling
script_start

export PATH=/u/home/eeskin/icnn/local/bin/:$PATH

OLB=/u/home/eeskin//jwhitake/Tools/OLB-1.9.4/bin
bcDir=$1
lane=$2
posDir=$bcDir/../L00$lane

rm -rf L00$lane

$OLB/setupBclToQseq.py -b $bcDir -p $posDir -o `pwd`/L00$lane

pushd L00$lane > /dev/null

mileDir=milestone
rm -rf $mileDir && mkdir $mileDir

awk 'NR<14' Makefile.config > temp.config;
awk -v i=$lane 'BEGIN {print "lanes := s_"i}' >> temp.config;
grep s_${lane}_tiles Makefile.config >> temp.config;
awk 'NR>22' Makefile.config >> temp.config;		
mv temp.config Makefile.config;
make;

echo INFO BCL conversion completed ... 1>&2
touch $mileDir/bcl2qseq

splitQseqByIndex.sh . 

for i in `ls *_qseq.txt`; do
    echo $i;
    qsub `which gzipit.sh` $i;
done



popd > /dev/null


script_end




