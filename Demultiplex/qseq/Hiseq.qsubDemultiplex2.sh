#!/bin/bash - 

#$ -V
#$ -cwd 

set -eux 

if [ $# -ne 1 ]; then
    echo Tag file needed
    exit 1
fi

tagfile=$1;

for i in `find -maxdepth 1 -name "L007"`; do echo `basename $i` | sed 's/L00//' ; done > lanes.txt

for lane in `cat lanes.txt`; do 
	pushd L00$lane > /dev/null
		ls s_${lane}_2_*_qseq.txt.gz > tagfiles.txt;
		len=`wc -l tagfiles.txt | awk '{print $1}'`;

		for tag in `cat ../$tagfile`; do 
			mkdir -p $tag;
		done;

		for j in `seq 1 $len`; do
			file=`awk -v j=$j 'NR==j' tagfiles.txt`;
			tile=`awk -v j=$j 'NR==j {split($1,a,"_"); print a[4]}' tagfiles.txt`;		
			qsub `which demultiplex2.sh` $lane $tile $tagfile; 
		done
		
		rm tagfiles.txt;
	popd > /dev/null
done	
