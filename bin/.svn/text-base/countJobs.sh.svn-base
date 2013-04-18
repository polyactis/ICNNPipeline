#!/bin/bash - 


[ `basename $1 | grep -c ".*\.sh\..*"` -ne 0 ] && echo "first argument must be output file" && exit 1
out=$1
shift

mkdir -p `dirname $out`

scriptName=`basename $2 | sed 's/\(\.sh\).*$/\1/'`

echo counting job completion statuses of $scriptName, in total of `echo $@ | wc -w` files ... 1>&2

for i in $@; do
    echo $i `tail $i | grep -c "^DONE .*$scriptName"`
done | tee >(awk '$2==0{print $1}' > $out) | awk '{print $2}' | sort | uniq -c 

echo saved elog files of uncompleted jobs in $out 1>&2

