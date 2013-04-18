#$ -cwd
#$ -l h_data=4G

set -e

if [ $# -ne 2 ]; then
	echo SYNOPSIS: `basename $0` fai sourceDir
	exit 1
fi

. ~/PIPELINE/bin/setGlobalEnv.sh

number=0-9MXY
ref=$1
sourceDir=`echo $2 | sed 's#/*$##'`
files=`find $sourceDir/ -regex .*.part[$number]*.sam`
for f in $files ; do
    fbam="`echo $f | sed 's/.sam/.bam/'`"
    if [ -f "$fbam" ]; then
        echo ERROR: output file $fbam exists 1>&2
        exit 1
    fi
    if [ -f "$f" ]; then
    	echo $f
	    time -p sam2bam.sh $ref $f
    fi
done
targetName=`echo $sourceDir | sed 's#^\.*/*##g' | sed 's#/#.#g'`.bam

if [ -f "$targetName" ]; then
    echo ERROR: output file $targetName exists 1>&2
    exit 1
fi

files=`echo $files | sed 's/\.sam\>/.bam/g'`
nf=`echo $files | awk '{print NF}'`
if [ $nf -eq 1 ]; then
    cp $files $targetName
    cp $files.bai $targetName.bai
else
    samtools merge $targetName $files
fi

sort_index_bam.sh $targetName

#rm $files
echo completed successfully! The SAM files can be removed. 1>&2



