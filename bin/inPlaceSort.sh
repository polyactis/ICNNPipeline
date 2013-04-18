#$ -cwd
set -o nounset                              # Treat unset variables as an error
if [ "x`echo $PATH | grep -o PIPELINE | uniq`" != "xPIPELINE" ]; then
    export PATH=.:~/PIPELINE/bin:$PATH:/u/local/bin
fi

tempFile=`getTempRandName.sh $@`

echo $tempFile

sort $@ > $tempFile
mv $tempFile $_
