#!/bin/bash - 

#$ -V
#$ -cwd 

set -e
source error_handling
script_start


if [ $# -ne 1 ]; then
    echo Tag file needed
    exit 1
fi

tagfile=$1;

for lane in `awk '{print $3}' samples.txt | sed 's/,/\n/g' | sort | uniq`; do 
	pushd L00$lane > /dev/null
		ls s_${lane}_2_*_qseq.txt > tagfiles.txt;
		len=`wc -l tagfiles.txt | awk '{print $1}'`;

		cat ../$tagfile | xargs mkdir -p

		for j in `seq 1 $len`; do
			file=`awk -v j=$j 'NR==j' tagfiles.txt`;
			tile=`awk -v j=$j 'NR==j {split($1,a,"_"); print a[4]}' tagfiles.txt`;		
			qsub `which demultiplex.sh` $lane $tile $tagfile; 
		done
		
		rm tagfiles.txt;
	popd > /dev/null
done	


script_end




