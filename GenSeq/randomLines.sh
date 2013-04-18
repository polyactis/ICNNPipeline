#$ -cwd

if [ $# -ne 2 ]; then
    echo SYNOPSIS: `basename $0` nsample 
    exit
fi

file=$1
total=`wc -l $file | awk '{print $1}'`
nsample=$2

echo $nsample $total
if [ $nsample -lt $total ]; then
    ~/PIPELINE/GenSeq/randomLines.awk -v nsample=$nsample -v total=$total $file > `dirname $file`/sample$nsample.`basename $file`
else
    pushd `dirname $file`
    ln -s $file sample$nsample.`basename $file`
    popd
fi
