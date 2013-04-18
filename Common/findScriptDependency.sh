set -eux

preFile=preFile
newFile=newFile

>$preFile

cat "$@" | grep -Eo "\w*\.(sh|awk)" | sort | uniq > $newFile

tempFile=tempFile

while [ `cat $newFile | wc -l` -ne 0 ]; do    
    cat $newFile $preFile | sort | uniq > $tempFile
    mv $tempFile $preFile
    depList="`cat $newFile`"
    for i in `echo $depList | grep -Eo "\w*\.(sh|awk)"`; do
        file=`which $i`
        if [ $? -eq 0 ]; then
            cat $file | grep -Eo "\w*\.(sh|awk)" 
        fi
    done | sort | uniq | join -a 1 - $preFile > $newFile
done

cat $preFile
rm -f $preFile $newFile $tempFile
