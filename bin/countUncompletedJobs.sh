scriptName=`basename $1 | sed 's/\(\.sh\).*$/\1/'`

out=`dirname $1`/countUncompletedJobs.`basename $scriptName .sh`.txt
>$out

echo counting job completion statuses of $scriptName ...
for i in $@; do
    echo $i `tail $i | grep -c "^DONE .*$scriptName"`
done | tee >(awk '$2==0{print $1}' > $out) | awk '{print $2}' | sort | uniq -c 

echo saved elog files of uncompleted jobs in $out

