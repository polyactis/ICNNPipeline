all=""
for i in "$@"; do
    s1=$((`head -4000 $i | wc -c`/1000))
    s2=$((`tail -4000 $i | wc -c`/1000))
    qsize=`ls -lL $i | awk '{print $5}'`
    if [ $(($s1+$s2)) -ne 0 ]; then
        qsize=`echo | awk -v q=$qsize -v s1=$s1 -v s2=$s2 '{print 2*q/(s1+s2)/1e+6}'`
    else
        qsize=0
    fi
    all="$all $qsize"
    printf "%.4f\t%s\n" $qsize $i
done
echo `echo $all | awk '{ sum=0; for(i=1;i<=NF;i++) sum += $i; print sum}'` "total"
