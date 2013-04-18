#!/bin/bash - 

#$ -V
#$ -cwd 
#$ -b y
#$ -l h_rt=24:00:00

set -e
source error_handling
script_start

export PATH=/u/home/eeskin/icnn/local/bin/:$PATH

OLB=/u/home/eeskin/jwhitake/Tools/OLB-1.9.4/bin
bcDir=$1
lane=$2
posDir=$bcDir/../L00$lane

mileDir=milestone

if [ ! -f L00$lane/$mileDir/bcl2qseq ]; then 

    rm -rf L00$lane && $OLB/setupBclToQseq.py -b $bcDir -p $posDir -o `pwd`/L00$lane

    pushd L00$lane > /dev/null


    mkdir -p $mileDir

    awk 'NR<14' Makefile.config > temp.config;
    awk -v i=$lane 'BEGIN {print "lanes := s_"i}' >> temp.config;
    grep s_${lane}_tiles Makefile.config >> temp.config;
    awk 'NR>22' Makefile.config >> temp.config;		
    mv temp.config Makefile.config;

    set +e
    make;
    set -e

    if [ -f finished.txt ]; then
        echo INFO BCL conversion completed ... 1>&2
        touch $mileDir/bcl2qseq
    else
        echo ERROR BCL conversion had problems ... 1>&2
        exit 1
    fi
else
    pushd L00$lane > /dev/null
fi

illuminaFile=`which illumina_indexes.txt`

tagList=`cat ../samples.txt | awk '$NF ~/'$lane'/{print $(NF-1)}' | sort | join - <(sort -k1,1 $illuminaFile) | cut -d' ' -f2 | xargs echo | sed 's/ /,/g'`
splitQseqByIndex.sh ./ $tagList ./

touch $mileDir/demultiplexed

echo INFO demultiplexing completed ... 1>&2

#gzip -f s_${lane}_*qseq.txt

popd > /dev/null

script_end
