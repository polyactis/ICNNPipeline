#$ -cwd
if [ $# -lt 1 ]; then
  echo SYNOPSIS: $0 alignmentDir 
  exit
fi

sourceDir=`echo $1 | sed 's#/*$##'`

echo reading SAMs from $sourceDir ...

targetName=`echo $sourceDir | sed 's#^\.*/*##g' | sed 's#/#.#g' | sed 's#.algn$##'`.allAlign

echo filtering to $targetName ...

number=0-9MXY

echo extracting from parts ...
files=`find $sourceDir/ -regex .*.part[$number]*.sam`
>$targetName
for f in $files ; do
	echo $f
   awk '$3 !~ /^*$/' >> $targetName
done




