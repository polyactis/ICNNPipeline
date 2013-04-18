#$ -cwd
#$ -l h_data=4G

if [ $# -ne 1 ]; then
	echo SYNOPSIS: `basename $0` sourceDir
	exit 1
fi

source error_handling

start_script

number=0-9MXY
sourceDir=`echo $1 | sed 's#/*$##'`

if ! [ -d "$sourceDir" ]; then
    echo $sourceDir is not a directory
    exit
fi

files=`find $sourceDir/ -regex .*.part[$number]*.bam`
targetName=`echo $sourceDir | sed 's#^\.*/*##g' | sed 's#/#.#g'`.bam

nf=`echo $files | awk '{print NF}'`

if [ $nf -eq 0 ]; then
    exit 1
fi
if [ $nf -eq 1 ]; then
    cp $files $targetName
    cp $files.bai $targetName.bai
else
    samtools merge $targetName $files
fi

sort_index_bam.sh $targetName

end_script



