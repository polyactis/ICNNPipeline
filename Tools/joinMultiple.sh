#$ -cwd

. ~/PIPELINE/bin/setGlobalEnv.sh

tempOut=`getTempRandName.sh`

tempIn=$1
shift
echo result is in file $tempIn

echo joining $1 ...
cp $1 $tempIn
shift


for i in "$@" ; do
    echo joining $i ...
    join $tempIn $i > $tempOut
    mv $tempOut $tempIn
    wc -l $tempIn
done

