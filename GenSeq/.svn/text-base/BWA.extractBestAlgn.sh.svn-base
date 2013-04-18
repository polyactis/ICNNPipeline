#$ -cwd
if [ $# -lt 1 ]; then
  echo SYNOPSIS: $0 alignmentDir 
  exit
fi

bin=~/pipeline/ChIP-seq/
sourceDir=`echo $1 | sed 's#/*$##'`

echo reading SAMs from $sourceDir ...

targetName=`echo $sourceDir | sed 's#^\.*/*##g' | sed 's#/#.#g' | sed 's#.algn$##'`.best.algn

echo filtering to $targetName ...

number=0-9MXY

echo extracting from parts ...
files=`find $sourceDir/ -regex .*.part[$number]*.sam`
>$targetName
for f in $files ; do
	echo $f
	awk '{ if ( /\<X0:i:1\>/ ) print $3 "\t" $4 "\t" (and($2,0x0010)? "R" : "F") }' $f >> $targetName 
done


