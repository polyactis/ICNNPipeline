#$ -cwd
if [ $# -lt 1 ]; then
  echo SYNOPSIS: $0 alignmentDir 
  exit
fi

sourceDir=`echo $1 | sed 's#/*$##'`

echo reading SAMs from $sourceDir ...

targetName=`echo $sourceDir | sed 's#^\.*/*##g' | sed 's#/$##' | sed 's#/#.#g'`.unique.bed
echo output to $targetName

echo filtering to $targetName ...

number=0-9MXY

echo extracting from parts ...
files=`find $sourceDir/ -regex .*.part[$number]*.sam`
#awkScript=`ls -l $0 | awk '{print $NF}' | sed 's/.sh/.awk/'`
#echo using $awkScript
awkScript=~/PIPELINE/bin/BWA.extractExonicUniqueAlgn.awk

>$targetName
for f in $files ; do
	echo $f
	$awkScript $f >> $targetName 
done




